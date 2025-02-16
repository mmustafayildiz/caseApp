import XCTest
@testable import caseApp

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        networkManager = NetworkManager(session: mockURLSession)
    }
    
    override func tearDown() {
        networkManager = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchUsers_Success() {
        // Arrange
        let jsonData = """
        [
            {
                "id": 1,
                "name": "John Doe",
                "username": "johndoe",
                "email": "john@example.com",
                "address": {
                    "street": "Main St",
                    "suite": "Apt. 1",
                    "city": "New York",
                    "zipcode": "10001",
                    "geo": { "lat": "0.0", "lng": "0.0" }
                },
                "phone": "123-456-7890",
                "website": "johndoe.com",
                "company": {
                    "name": "Tech Inc",
                    "catchPhrase": "Innovate your world",
                    "bs": "tech solutions"
                }
            }
        ]
        """.data(using: .utf8)!
        
        mockURLSession.mockData = jsonData
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/users")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: nil)
        
        let expectation = self.expectation(description: "FetchUsersSuccess")
        
        // Act
        networkManager.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "John Doe")
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchUsers_Failure() {
        // Arrange
        mockURLSession.mockError = NSError(domain: "NetworkError", code: -1, userInfo: nil)
        
        let expectation = self.expectation(description: "FetchUsersFailure")
        
        // Act
        networkManager.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}

// MARK: - Mock URLSession
class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionDataTask {
        let task = MockURLSessionDataTask()
        task.completionHandler = {
            completionHandler(self.mockData, self.mockResponse, self.mockError)
        }
        return task
    }
}

class MockURLSessionDataTask {
    var completionHandler: (() -> Void)?
    
    func resume() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            self.completionHandler?()
        }
    }
}
