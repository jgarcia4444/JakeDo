//
//  Item.swift
//  JakeDo
//
//  Created by Jake Garcia on 8/22/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dateCreated: Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
