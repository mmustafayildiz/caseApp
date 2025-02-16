# CaseApp

## 📌 Project Description
This is a simple iOS application built using Swift and the MVVM architecture. The app fetches user data from the JSONPlaceholder API and displays it in a table view. Users can navigate to a detail screen to see more information about a selected user.

## 🛠 Technologies & Architecture
- **Language:** Swift
- **Architecture:** MVVM (Model-View-ViewModel)
- **Networking:** URLSession
- **Dependency Management:** No external dependencies
- **UI Framework:** UIKit
- **Data Source:** JSONPlaceholder API

## 🚀 Features
### User List Screen
- Fetches a list of users from the API.
- Displays user names and emails in a table view.
- Tapping a user navigates to the detail screen.

### User Detail Screen
- Displays detailed information about the selected user, including:
  - Name
  - Email
  - Phone
  - Website

## 📂 Project Structure
```
CaseApp/
│── Model/            # Data models
│── ViewModel/        # View models for MVVM pattern
│── ViewController/   # UI logic & controllers
│── Networking/       # NetworkManager for API requests
│── Repository/       # Repository layer for data management
│── Resources/        # Assets and other resources
│── Tests/            # Unit tests
```

## 🧪 Unit Testing
The project includes unit tests for:
- `UserListViewModel`
- `UserRepository`
- `NetworkManager`

## 📦 Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/mmustafayildiz/caseApp.git
   ```
2. Open `CaseApp.xcodeproj` in Xcode.
3. Build and run the project on a simulator or physical device.

## ✅ Future Improvements
- Improve error handling in networking layer.
- Enhance UI with better design and animations.
- Add support for offline data caching.

## 🤝 Contributing
Feel free to fork this project, open issues, and submit pull requests!


