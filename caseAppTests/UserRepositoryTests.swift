import XCTest
@testable import caseApp

// MARK: - UserRepositoryTests
// Unit tests for UserRepository to verify fetching users from the network layer.
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
    
    // MARK: - Test Cases
    // Tests successful fetching of users from the repository.
    func testFetchUsers_Success() {
        // Arrange: Set up mock users to return.
        let mockUsers = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com",
                 address: Address(street: "Main St", suite: "Apt. 1", city: "New York", zipcode: "10001", geo: Geo(lat: "0.0", lng: "0.0")),
                 phone: "123-456-7890", website: "johndoe.com", company: Company(name: "Tech Inc", catchPhrase: "Innovate your world", bs: "tech solutions"))
        ]
        mockNetworkManager.mockUsers = mockUsers
        
        let expectation = self.expectation(description: "FetchUsersSuccess")
        
        // Act: Call fetchUsers method.
        userRepository.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "John Doe")
                print("✅ testFetchUsers_Success executed successfully!")
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    // Tests failure case when fetching users from the repository.
    func testFetchUsers_Failure() {
        // Arrange: Set network manager to return an error.
        mockNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "FetchUsersFailure")
        
        // Act: Call fetchUsers method.
        userRepository.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                print("✅ testFetchUsers_Failure executed successfully!")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}

// MARK: - Mock Network Manager
// A mock implementation of NetworkManagerProtocol for testing purposes.
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
