import UIKit

class EmojiTableViewCell: UITableViewCell {
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 22).isActive = true
        return label
    }()
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupCell()
        }
    
    private func setupCell() {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
    
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        horizontalStackView.addArrangedSubview(emojiLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.spacing = 10
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
                horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
                horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
                horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            ])
    }
    
    func set(object: Emoji) {
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.descriptionLabel.text = object.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
