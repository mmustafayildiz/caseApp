import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol  // Protokole bağladık

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        networkManager.fetchUsers(completion: completion)
    }
}
