//
//  Checklist.swift
//  Checklists
//
//  Created by Luis Faz on 1/30/24.
//

import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  var iconName = "No Icon"
  var items = [ChecklistItem]()

  init(name: String, iconName: String = "No Icon") {
    self.name = name
    self.iconName = iconName
    super.init()
  }

  func countUncheckedItems() -> Int {
    var count = 0
    for item in items where !item.checked {
      count += 1
    }
    return count
  }
}
