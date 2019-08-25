//
//  ToDoListViewController.swift
//  JakeDo
//
//  Created by Jake Garcia on 8/22/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: UITableViewController, UISearchBarDelegate {
    
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory: Category? {
        didSet {
           loadItems()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        

    }
    // Mark: - Tableview data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isDone ? .checkmark : .none
        }
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.isDone  = !item.isDone
                }
            } catch {
                print("Error with togglinng the checkmark for the item: \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (itemTextField) in
            itemTextField.placeholder = "Add New Item"
            textField = itemTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (addItem) in
            
            let newItem = Item()
            newItem.title = textField.text!
            newItem.isDone = false
            newItem.dateCreated = Date()
            
            self.saveItem(item: newItem)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    
    // MARK: - Save And Load Items
    func saveItem(item: Item) {
        
        do {
            try realm.write {
                selectedCategory?.items.append(item)
            }
        } catch {
            print("Error saving the new item")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Search Bar Delgate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
        }
    }
    
    

}
