import UIKit

// MARK: - UserDetailTableViewCell
// This UITableViewCell subclass is responsible for displaying detailed user information in the detail screen.
class UserDetailTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    // Icon representing the type of detail (e.g., email, phone, etc.)
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Title label (e.g., "Email", "Phone")
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // Value label displaying the actual user information
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0 // Allows multiline display
        return label
    }()
    
    // StackView to arrange title and value vertically
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
        
        // MARK: - Layout Constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Method
    // Configures the cell with icon, title, and value data.
    func configure(icon: String, title: String, value: String) {
        iconImageView.image = UIImage(systemName: icon)
        titleLabel.text = title
        valueLabel.text = value
    }
}
