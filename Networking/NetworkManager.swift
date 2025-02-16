import Foundation


protocol NetworkManagerProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}


class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private let session: URLSession
    
    internal init(session: URLSession = URLSession.shared) {
           self.session = session
       }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
