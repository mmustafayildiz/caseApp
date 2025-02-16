import Foundation

class UserListViewModel {
    private let networkManager: NetworkManager
    private(set) var users: [User] = []
    var onUsersUpdated: (() -> Void)?

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchUsers() {
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.onUsersUpdated?()
            case .failure(let error):
                print("Error fetching users: \(error)")
            }
        }
    }

    func getUser(at index: Int) -> User? {
        guard index < users.count else { return nil }
        return users[index]
    }
}
