//
//  ViewController.swift
//  TodoApp
//
//  Created by Filip Handzel on 02/05/2020.
//  Copyright © 2020 Filip Handzel. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]() //custom objects
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Maszeczka"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Maszeńka"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Chruptusia"
        itemArray.append(newItem3)
        
//        for i in 1...90 {
//            let i = itemArray.append(newItem2)
//        }
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAtIndexPath")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            //what will happen once he user clicks the Add Item button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    alert.addAction(action)
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new task"
        textField = alertTextField
        }
        
    present(alert, animated: true, completion: nil)
    }
}


//userDefaults better use with settings volume, brightness etc for example
