import UIKit

class NewEmojiTableViewController: UITableViewController {
    var cancelButton = UIBarButtonItem()
    var saveButton = UIBarButtonItem()
    
    let namesSection = ["Emoji", "Name", "Description"]
    let textFields = [UITextField(), UITextField(), UITextField()]
    
    var onDataReceived: ((Emoji) -> Void)?
    var emoji = Emoji(emoji: "", name: "", description: "", isFavorite: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.backgroundColor = .systemGray6
        
        cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(goBack))
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        saveButton.isEnabled = false
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
        for item in textFields {
            item.addTarget(self, action: #selector(updateSaveButton), for: .editingChanged)
        }
        
        textFields[0].text = emoji.emoji
        textFields[1].text = emoji.name
        textFields[2].text = emoji.description
    }
    
    @objc func updateSaveButton() {
        let emojiText = textFields[0].text ?? ""
        let nameText = textFields[1].text ?? ""
        let descriptionText = textFields[2].text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        let emoji = textFields[0].text ?? ""
        let name = textFields[1].text ?? ""
        let description = textFields[2].text ?? ""
        
        let emojiValue = Emoji(emoji: emoji, name: name, description: description , isFavorite: self.emoji.isFavorite)
        onDataReceived?(emojiValue)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return namesSection[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let textField = textFields[indexPath.section]
        cell.contentView.addSubview(textField)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -5),
            textField.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 5)
        ])
        
        return cell
    }
}

