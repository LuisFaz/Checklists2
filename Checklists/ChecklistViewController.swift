//
//  ViewController.swift
//  Checklists
//
//  Created by Luis Faz on 1/24/24.
//

import UIKit

// ChecklistViewController is a UITableViewController and adopts the ItemDetailViewControllerDelegate protocol.
class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    // An array to store ChecklistItem objects representing checklist items.
    var items = [ChecklistItem]()

    // Called when the view controller's content view is created.
    override func viewDidLoad() {
      super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
      // Load items
      loadChecklistItems()
    }
    // MARK: - Navigation
    
    // Prepare for navigation segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            // If the segue is for adding an item, set the delegate for ItemDetailViewController.
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            // If the segue is for editing an item, set the delegate and pass the item to ItemDetailViewController.
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

    // MARK: - Actions
    
    // Configures the checkmark label of a UITableViewCell based on the ChecklistItem's checked status.
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }

    // Configures the text label of a UITableViewCell with the ChecklistItem's text.
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    // MARK: - Table View Data Source
    
    // Returns the number of items in the checklist.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // Configures and returns a cell for a given row in the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)

        let item = items[indexPath.row]

        // Configure the text and checkmark for the cell.
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)

        return cell
    }

    // MARK: - Table View Delegate
    
    // Handles the selection of a table view cell.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            // Toggle the checked status of the selected item and update the cell's appearance.
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }

        // Deselect the row to visually indicate the interaction.
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveChecklistItems()
    }

    // Handles editing style for a table view cell (e.g., deletion).
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1. Remove the item from the items array.
        items.remove(at: indexPath.row)

        // 2. Delete the corresponding row in the table view.
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        saveChecklistItems()
    }

    // MARK: - Add Item ViewController Delegates
    
    // Called when the user cancels adding or editing an item.
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }

    // Called when the user finishes adding a new item.
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        // Add the new item to the items array and update the table view.
        let newRowIndex = items.count
        items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        // Dismiss the ItemDetailViewController.
        navigationController?.popViewController(animated: true)
        
        saveChecklistItems()
    }

    // Called when the user finishes editing an existing item.
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item) {
            // Update the text label for the cell corresponding to the edited item.
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }

        // Dismiss the ItemDetailViewController.
        navigationController?.popViewController(animated: true)
        
        saveChecklistItems()
    }
    
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }
    func dataFilePath() -> URL {
      return
    documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
      let encoder = PropertyListEncoder()
      do {
        let data = try encoder.encode(items)
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
      } catch {
        print("Error encoding item array: \(error.localizedDescription)")
      }
    }
    
    func loadChecklistItems() {
      let path = dataFilePath()
      if let data = try? Data(contentsOf: path) {
        let decoder = PropertyListDecoder()
        do {
          items = try decoder.decode(
            [ChecklistItem].self,
            from: data)
        } catch {
          print("Error decoding item array: \(error.localizedDescription)")
        }
      }
    }

}
