import Foundation

// MARK: - UserListViewModel
// This ViewModel is responsible for handling the business logic of the User List screen.
// It interacts with the UserRepository to fetch user data and notifies the View when updates occur.
class UserListViewModel {
    
    private let userRepository: UserRepositoryProtocol // Repository for handling data operations
    var users: [User] = [] // Stores the list of fetched users
    var onUsersUpdated: (() -> Void)? // Closure to notify the View when data is updated
    
    // Dependency Injection: Allows using a custom repository for testing or different implementations.
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    // Fetches users from the repository and updates the users array.
    func fetchUsers() {
        userRepository.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.onUsersUpdated?() // Notify the View when data changes
            case .failure(let error):
                print("Error fetching users: \(error)") // Handle errors appropriately (logging, UI updates, etc.)
            }
        }
    }
    
    // Returns a specific user at the given index, if it exists.
    func getUser(at index: Int) -> User? {
        return index < users.count ? users[index] : nil
    }
}
