//
//  SwipeCellViewController.swift
//  JakeDo
//
//  Created by Jake Garcia on 8/25/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift

class SwipeCellViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.transitionStyle = .reveal
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        // override this function in the other two controllers to handle deleting the item or category
    }

}
