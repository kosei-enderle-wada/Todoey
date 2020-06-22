//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print(dataFilePath)
        
        var newItem1 = Item()
        newItem1.title = "title1"
        itemArray.append(newItem1)
        itemArray.append(newItem1)
        itemArray.append(newItem1)
        itemArray.append(newItem1)
        // Do any additional setup after loading the view.
                if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
                    itemArray = items
                }
    }
    
    //MARK - tableview datasource methods
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel!.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New todo item?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            var newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
                    
            }catch{
                print("error at saving data")
            }
        
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


//add some comment

