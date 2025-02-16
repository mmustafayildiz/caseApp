import XCTest
@testable import caseApp

class UserRepositoryTests: XCTestCase {
    
    var userRepository: UserRepository!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        userRepository = UserRepository(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        userRepository = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testFetchUsers_Success() {
        // Arrange
        let mockUsers = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com",
                 address: Address(street: "Main St", suite: "Apt. 1", city: "New York", zipcode: "10001", geo: Geo(lat: "0.0", lng: "0.0")),
                 phone: "123-456-7890", website: "johndoe.com", company: Company(name: "Tech Inc", catchPhrase: "Innovate your world", bs: "tech solutions"))
        ]
        mockNetworkManager.mockUsers = mockUsers
        
        let expectation = self.expectation(description: "FetchUsersSuccess")
        
        // Act
        userRepository.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "John Doe")
                print("✅ testFetchUsers_Success çalıştı!")
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchUsers_Failure() {
        // Arrange
        mockNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "FetchUsersFailure")
        
        // Act
        userRepository.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                print("✅ testFetchUsers_Failure çalıştı!")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}

// MARK: - Mock Network Manager
class MockNetworkManager: NetworkManagerProtocol {
    var mockUsers: [User] = []
    var shouldReturnError = false
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockUsers))
        }
    }
}
