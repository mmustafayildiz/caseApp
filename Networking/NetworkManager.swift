import Foundation

// MARK: - NetworkManagerProtocol
// This protocol defines a contract for fetching users from an API.
protocol NetworkManagerProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

// MARK: - NetworkManager
// This class is responsible for handling network requests.
// It follows the singleton pattern to ensure a single instance is used throughout the app.
class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager() // Shared singleton instance
    private let session: URLSession // URLSession instance for network requests
    
    // Private initializer to enforce singleton usage, allowing dependency injection for testing.
    internal init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // Fetches a list of users from the JSONPlaceholder API.
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        // Ensure the URL string is valid, otherwise return an error.
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Create a data task to fetch data from the API.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle networking error.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is received, otherwise return an error.
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            // Decode the JSON data into an array of User objects.
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume() // Start the network request.
    }
}
