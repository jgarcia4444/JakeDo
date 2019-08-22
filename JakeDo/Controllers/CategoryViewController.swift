//
//  CategoryViewController.swift
//  JakeDo
//
//  Created by Jake Garcia on 8/21/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    let categories: Results<Category>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        
        tableView.delegate = self
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
        } else {
            cell.textLabel?.text = "Add Category"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    //MARK: - IBActions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Category", message: "Add New Category", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add New Category"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (addAction) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            self.saveCategory(category: newCategory)
        }
        
        
        alert.addAction(action)
        
        present(alert, animated:true)
    }
    
    func saveCategory(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving the new category: \(error)")
        }
        tableView.reloadData()
    }
    
    
}
