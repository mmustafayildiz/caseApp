import XCTest
@testable import caseApp

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
    
    func testFetchUsers_Success() {
        // Arrange
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
        
        // Act
        viewModel.fetchUsers()
        
        // Assert
        XCTAssertEqual(viewModel.users.count, mockUsers.count)
        XCTAssertEqual(viewModel.users.first?.name, "John Doe")
    }
    
    func testFetchUsers_Failure() {
        // Arrange
        mockRepository.shouldReturnError = true
        
        // Act
        viewModel.fetchUsers()
        
        // Assert
        XCTAssertTrue(viewModel.users.isEmpty)
    }
}

// Mock User Repository
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
