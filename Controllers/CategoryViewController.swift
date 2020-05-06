//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by Filip Handzel on 06/05/2020.
//  Copyright © 2020 Filip Handzel. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let contextCategory = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoryArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //print("cellForRowAtIndexPath")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath);
            
            let category = categoryArray[indexPath.row]
            
            cell.textLabel?.text = category.name
            
            return cell
        }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            contextCategory.delete(categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
        
            tableView.deselectRow(at: indexPath, animated: true)
        
            saveCategories()
         }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
              
              let alert = UIAlertController(title: "Add new categories", message: "", preferredStyle: .alert)
          
              let action = UIAlertAction(title: "Add category", style: .default) { (action) in
                  //what will happen once he user clicks the Add Item button
                  
                  let newCategory = Category(context: self.contextCategory)
                  newCategory.name = textField.text!
                  self.categoryArray.append(newCategory)
                  
                  self.saveCategories()
              }
              
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          
          alert.addAction(action)
              alert.addTextField { (alertTextField) in
              alertTextField.placeholder = "Create new task"
              textField = alertTextField
              }
              
          present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data Manipulation Methods
    
     func saveCategories() { //Create as C!
            
            do {
                try contextCategory.save()
            } catch {
                print("Error saving/create context \(error)")
            }
            self.tableView.reloadData()
        }
        
        func loadCategories() { //Read as R!
            let request : NSFetchRequest<Category> = Category.fetchRequest()
            do {
            categoryArray = try contextCategory.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
            }
        }
    }
