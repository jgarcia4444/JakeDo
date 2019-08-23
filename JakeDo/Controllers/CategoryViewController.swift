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
    
    var categories: Results<Category>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        tableView.delegate = self
        
        loadCategories()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let categoriesCount = categories?.count {
            return categoriesCount
        } else {
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            cell.backgroundColor = UIColor(hexString: category.color)
        } else {
            cell.textLabel?.text = "Add category"
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
            print(newCategory)
            self.saveCategory(category: newCategory)
            self.loadCategories()
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
        
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
}
