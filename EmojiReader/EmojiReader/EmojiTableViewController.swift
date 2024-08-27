import UIKit

class EmojiTableViewController: UITableViewController {
    var objects = [
    Emoji(emoji: "🤒", name: "Ill", description: "llflld", isFavorite: false),
    Emoji(emoji: "🤡", name: "Clown", description: "Ha ha ha ha ha", isFavorite: false),
    Emoji(emoji: "😍", name: "Love", description: "love love", isFavorite: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EmojiTableViewCell.self, forCellReuseIdentifier: "cell")
        
        title = "Emoji Reader"
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToNewEmojiTableViewController))
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func goToNewEmojiTableViewController() {
        let newEmoji = NewEmojiTableViewController()
        let navigationController = UINavigationController(rootViewController: newEmoji)
        navigationController.modalPresentationStyle = .formSheet
        newEmoji.onDataReceived = { [weak self] data in
            self?.objects.append(data)
            self?.tableView.reloadData()
        }
        self.present(navigationController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmojiTableViewCell
        
        let object = objects[indexPath.row]
        cell.set(object: object)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newEmoji = NewEmojiTableViewController()
        let navigationController = UINavigationController(rootViewController: newEmoji)
        navigationController.modalPresentationStyle = .formSheet
        newEmoji.emoji = self.objects[indexPath.row]
        newEmoji.onDataReceived = { [weak self] data in
            self?.objects[indexPath.row] = data
            self?.tableView.reloadData()
        }
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // кнопка edit будет удалять элементы
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // перемещение
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favorite = favoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favorite] )
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        
        return action
    }
    
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = self.objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "favorite") { action, view, completion in
            object.isFavorite = !object.isFavorite
            self.objects[indexPath.row] = object
            completion(true)
        }
        
        action.backgroundColor = object.isFavorite ? .purple : .lightGray
        action.image = UIImage(systemName: "heart")
        
        return action
    }
}
