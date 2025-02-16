import UIKit

// MARK: - UserListViewController
// This ViewController is responsible for displaying a list of users in a table view.
// It fetches user data using UserListViewModel and updates the UI accordingly.
class UserListViewController: UIViewController {
    
    private let tableView = UITableView() // TableView to display users
    private let viewModel = UserListViewModel() // ViewModel for handling business logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUsers() // Fetch users when the view loads
    }
    
    // MARK: - UI Setup
    // Configures the UI elements of the ViewController.
    private func setupUI() {
        title = "Users"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.orange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.separatorStyle = .singleLine
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - ViewModel Binding
    // Binds the ViewModel to update the table view when new data is available.
    private func bindViewModel() {
        viewModel.onUsersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
// Handles table view data population and user interaction.
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        if let user = viewModel.getUser(at: indexPath.row) {
            cell.configure(with: user)
        }
        return cell
    }
    
    // Handles user selection, navigating to the detail screen.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userDetailVC = UserDetailViewController()
        if let user = viewModel.getUser(at: indexPath.row) {
            userDetailVC.user = user
        }
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
