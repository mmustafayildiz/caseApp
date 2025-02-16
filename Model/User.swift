import Foundation

// MARK: - User Model
// This struct represents a User fetched from the JSONPlaceholder API.
// It conforms to the Codable protocol, allowing easy encoding and decoding from JSON.
struct User: Codable {
    let id: Int           // Unique identifier for the user
    let name: String      // Full name of the user
    let username: String  // Username of the user
    let email: String     // Email address of the user
    let address: Address  // Address details (nested struct)
    let phone: String     // Phone number of the user
    let website: String   // Website URL of the user
    let company: Company  // Company details (nested struct)
}

// MARK: - Address Model
// This struct represents the user's address details.
struct Address: Codable {
    let street: String    // Street name
    let suite: String     // Suite or apartment number
    let city: String      // City name
    let zipcode: String   // ZIP code
    let geo: Geo         // Geographical coordinates (nested struct)
}

// MARK: - Geo Model
// This struct represents geographical coordinates (latitude & longitude) of the user's address.
struct Geo: Codable {
    let lat: String  // Latitude coordinate
    let lng: String  // Longitude coordinate
}

// MARK: - Company Model
// This struct represents the company details of the user.
struct Company: Codable {
    let name: String        // Company name
    let catchPhrase: String // Company slogan or catchphrase
    let bs: String          // Business strategy or keywords related to the company
}
