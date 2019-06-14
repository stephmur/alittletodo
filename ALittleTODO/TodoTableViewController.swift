//
//  TableViewController.swift
//  ALittleTODO
//
//  Created by Stephen Murphy on 6/13/19.
//  Copyright © 2019 Stephen C. Murphy. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController, DataEnteredDelegate {

    // MARK: - Model
    
    var todoList: Todo?
    
    // MARK: - Storyboard
    
    var document: TodoDocument?
    
    func documentChanged() {
        document?.todoList = todoList
        if document?.todoList != nil {
            document?.updateChangeCount(.done)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // TODO: Upgrade to have 2 sections, one for current items, one for completed items.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList?.todos.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = todoList?.todos[indexPath.row].text

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoList?.todos.remove(at: indexPath.row)
            documentChanged()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        guard let todoItem = todoList?.todos.remove(at: fromIndexPath.row) else { return }
        todoList?.todos.insert(todoItem, at: to.row)
        documentChanged()
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.contents as? AddItemViewController {
            vc.delegate = self
        }
    }
    
    func userDidEnterInformation(todoText: String) {
        let endIndex = todoList?.todos.endIndex ?? 0
        todoList?.todos.insert(Todo.TodoItem(complete: false, text: todoText), at: endIndex)
        document?.todoList = todoList
        document?.save(to: document!.fileURL, for: .forOverwriting, completionHandler: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                self.title = self.document?.localizedName
                self.todoList = self.document?.todoList
                
                // Debug
                for todo in self.todoList!.todos {
                    print(todo.text ?? "unknown")
                }
                
                self.tableView.reloadData()
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        document?.close()
    }

    @IBAction func dismissTodoDocumentViewController(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
