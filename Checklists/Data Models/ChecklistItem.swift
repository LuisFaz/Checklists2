//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Luis Faz on 1/24/24.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    override init() {
      super.init()
      itemID = DataModel.nextChecklistItemID()
    }
}
