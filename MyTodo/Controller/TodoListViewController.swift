//
//  ViewController.swift
//  MyTodo
//
//  Created by ENG-Abdelrahman on 5/2/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Find Milk"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Buy Egges"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Destroy Pubg"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArrays") as? [Item]
        {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New MyTodo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text
            {
                let newItem = Item()
                newItem.title = text
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArrays")
                self.tableView.reloadData()
            }else
            {
                print("Write something")
            }
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

