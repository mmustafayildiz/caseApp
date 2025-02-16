import XCTest
@testable import caseApp

// MARK: - UserListViewModelTests
// Unit tests for UserListViewModel to verify fetching users functionality.
class UserListViewModelTests: XCTestCase {
    
    var viewModel: UserListViewModel!
    var mockRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        viewModel = UserListViewModel(userRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    // Tests successful fetching of users.
    func testFetchUsers_Success() {
        // Arrange: Set up mock users to return.
        let mockUsers = [
            User(
                id: 1,
                name: "John Doe",
                username: "johndoe",
                email: "john@example.com",
                address: Address(street: "Main St", suite: "Apt. 1", city: "New York", zipcode: "10001", geo: Geo(lat: "0.0", lng: "0.0")),
                phone: "123-456-7890",
                website: "johndoe.com",
                company: Company(name: "Tech Inc", catchPhrase: "Innovate your world", bs: "tech solutions")
            )
        ]
        mockRepository.mockUsers = mockUsers
        
        // Act: Call fetchUsers method.
        viewModel.fetchUsers()
        
        // Assert: Check if the fetched users match the mock data.
        XCTAssertEqual(viewModel.users.count, mockUsers.count)
        XCTAssertEqual(viewModel.users.first?.name, "John Doe")
    }
    
    // Tests failure case when fetching users.
    func testFetchUsers_Failure() {
        // Arrange: Set repository to return an error.
        mockRepository.shouldReturnError = true
        
        // Act: Call fetchUsers method.
        viewModel.fetchUsers()
        
        // Assert: Verify that users array remains empty on failure.
        XCTAssertTrue(viewModel.users.isEmpty)
    }
}

// MARK: - Mock User Repository
// A mock implementation of UserRepositoryProtocol for testing purposes.
class MockUserRepository: UserRepositoryProtocol {
    var mockUsers: [User] = []
    var shouldReturnError = false
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockUsers))
        }
    }
}
