import UIKit

// MARK: - UserDetailViewController
// This ViewController is responsible for displaying detailed information about a selected user.
class UserDetailViewController: UIViewController {
    
    var user: User?  // Stores the selected user details
    
    private let tableView = UITableView() // TableView to display user details
    private var details: [(icon: String, title: String, value: String)] = [] // Stores user details with icons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - UI Setup
    // Configures the appearance and layout of UI elements.
    private func setupUI() {
        view.backgroundColor = .white
        title = "User Detail"
        tableView.backgroundColor = .white
        
        // Navigation Bar Styling
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.orange
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        // TableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Data Setup
    // Populates the details array with the user's information.
    private func setupData() {
        guard let user = user else { return }
        
        details.append((icon: "person.fill", title: "Name", value: user.name))
        details.append((icon: "envelope.fill", title: "Email", value: user.email))
        details.append((icon: "phone.fill", title: "Phone", value: user.phone))
        details.append((icon: "globe", title: "Website", value: user.website))
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
// Handles table view data population.
extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? UserDetailTableViewCell else {
            return UITableViewCell()
        }
        let detail = details[indexPath.row]
        cell.configure(icon: detail.icon, title: detail.title, value: detail.value)
        return cell
    }
}
