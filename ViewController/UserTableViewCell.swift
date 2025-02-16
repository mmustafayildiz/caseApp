import UIKit

// MARK: - UserTableViewCell
// This UITableViewCell subclass is responsible for displaying user information in a table view cell.
class UserTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    // User profile icon
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill") // Default user icon
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // User name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // User email label
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // Email icon
    private let mailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill") // Email icon
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Chevron icon indicating navigation
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right") // Right arrow icon
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // StackView for arranging labels vertically
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        backgroundColor = .white
        stackView.addArrangedSubview(nameLabel)
        
        let emailStackView = UIStackView()
        emailStackView.axis = .horizontal
        emailStackView.spacing = 6
        emailStackView.addArrangedSubview(mailIcon)
        emailStackView.addArrangedSubview(emailLabel)
        
        stackView.addArrangedSubview(emailStackView)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(chevronImageView)
        
        // MARK: - Layout Constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -12),
            
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 16),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16),
            
            mailIcon.widthAnchor.constraint(equalToConstant: 16),
            mailIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Method
    // Populates the cell with user data
    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
}
