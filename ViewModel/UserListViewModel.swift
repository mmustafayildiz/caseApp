import Foundation

class UserListViewModel {
    private let userRepository: UserRepositoryProtocol
    var users: [User] = []
    var onUsersUpdated: (() -> Void)?

    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }

    func fetchUsers() {
        userRepository.fetchUsers { [weak self] result in
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
        return index < users.count ? users[index] : nil
    }
}
