//
//  ViewController.swift
//  Checklists
//
//  Created by Luis Faz on 1/24/24.
//

import UIKit

    class ChecklistViewController: UITableViewController {

        // MARK: - Table View Data Source
        override func tableView(
          _ tableView: UITableView,
          numberOfRowsInSection section: Int
        ) -> Int {
        return 1 }
        override func tableView(
          _ tableView: UITableView,
          cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
          return cell
        }

}

