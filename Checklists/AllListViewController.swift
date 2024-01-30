//
//  AllListViewController.swift
//  Checklists
//
//  Created by Luis Faz on 1/30/24.
//

//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Luis Faz on 1/30/24.
//

import UIKit

let cellIdentifier = "ChecklistCell"

class AllListsViewController: UITableViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:
        cellIdentifier)
        
    }

    // MARK: - Table view data source

    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
    return 3 }
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier, for: indexPath)
      cell.textLabel!.text = "List \(indexPath.row)"
      return cell
    }
    
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
      performSegue(withIdentifier: "ShowChecklist", sender: nil)
    }

}
