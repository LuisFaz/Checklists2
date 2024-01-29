//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Luis Faz on 1/24/24.
//

import Foundation

// ChecklistItem is a simple class representing an item in a checklist.
class ChecklistItem: NSObject, Codable {
    
    // The text associated with the checklist item.
    var text = ""
    
    // A boolean indicating whether the checklist item is checked or unchecked.
    var checked = false
}
