//
//  CategoryViewController.swift
//  JakeDo
//
//  Created by Jake Garcia on 8/21/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    let categories: Results<Category>? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none

    }
    
    //MARK: - Table View data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let categoryName = categories?[indexPath.row].name {
            cell.textLabel?.text = categoryName
        } else {
            cell.textLabel?.text = "Add Category"
        }
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        
    }
    
    func saveCategory(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving the category: \(error)")
        }
    }
    
}
