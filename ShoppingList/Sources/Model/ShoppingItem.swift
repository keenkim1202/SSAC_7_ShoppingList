//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by KEEN on 2021/10/14.
//

import Foundation
import RealmSwift

class ShoppingItem: Object {
  @Persisted var name: String
  @Persisted var isChecked: Bool
  @Persisted var isStared: Bool

  @Persisted(primaryKey: true) var _id: ObjectId
  
  convenience init(name: String) {
    self.init()
    
    self.name = name
    self.isChecked = false
    self.isStared = false
  }
}
