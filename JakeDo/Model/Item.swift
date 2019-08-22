//
//  Item.swift
//  JakeDo
//
//  Created by Jake Garcia on 8/21/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var isDone : Bool = false
    let category = LinkingObjects(fromType: Category.self, property: "items")
}
