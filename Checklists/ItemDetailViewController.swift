//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Luis Faz on 1/26/24.
//

import UIKit

// Protocol defining methods that the delegate (e.g., ChecklistViewController) must implement.
protocol ItemDetailViewControllerDelegate: AnyObject {
    // Called when the user cancels adding or editing an item.
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    
    // Called when the user finishes adding a new item.
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    
    // Called when the user finishes editing an existing item.
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

// ItemDetailViewController is a UITableViewController and adopts the UITextFieldDelegate protocol.
class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    // IBOutlet to connect the "Done" button in the storyboard.
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // IBOutlet to connect the text field in the storyboard.
    @IBOutlet weak var textField: UITextField!
    
    // Weak reference to the delegate conforming to the ItemDetailViewControllerDelegate protocol.
    weak var delegate: ItemDetailViewControllerDelegate?
    
    // Optional ChecklistItem to be edited (nil if adding a new item).
    var itemToEdit: ChecklistItem?
    
    // MARK: - View Lifecycle
    
    // Called when the view controller's content view is created.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Disable large titles for this view controller.
        navigationItem.largeTitleDisplayMode = .never
        
        // If editing an existing item, set the title and text field accordingly.
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    // MARK: - Actions
    
    // Called when the "Cancel" button is tapped.
    @IBAction func cancel() {
        // Notify the delegate that the user canceled the operation.
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    // Called when the "Done" button is tapped.
    @IBAction func done() {
        if let item = itemToEdit {
            // If editing, update the existing item and notify the delegate.
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            // If adding, create a new item, set its text, and notify the delegate.
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    // MARK: - Table View Delegates
    
    // Prevents cell selection in the table view.
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // Called just before the view appears on the screen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make the text field the first responder, bringing up the keyboard.
        textField.becomeFirstResponder()
    }
    
    // MARK: - Text Field Delegates
    
    // Called when characters in the text field are about to change.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        // Enable or disable the "Done" button based on whether the text field is empty.
        doneBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
    // Called when the user taps the "Clear" button in the text field.
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Disable the "Done" button when the text field is cleared.
        doneBarButton.isEnabled = false
        return true
    }
}

