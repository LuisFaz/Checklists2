//
//  Checklist.swift
//  Checklists
//
//  Created by Luis Faz on 1/30/24.
//

import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  var items = [ChecklistItem]()

  init(name: String) {
    self.name = name
    super.init()
  }
}
