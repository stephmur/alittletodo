//
//  TodoListViewController.swift
//  ALittleTODO
//
//  Created by Stephen Murphy on 6/12/19.
//  Copyright © 2019 Stephen C. Murphy. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController
{
    
    // MARK: - Model
    
    var todoList: TodoList?
    
    // MARK: - Storyboard
    
    @IBOutlet weak var documentNameLabel: UILabel!
    
    var document: TodoListDocument?
    
    func documentChanged() {
        document?.todoList = todoList
        if document?.todoList != nil {
            document?.updateChangeCount(.done)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                self.title = self.document?.localizedName
                self.todoList = self.document?.todoList
                for todo in self.todoList!.todos {
                    print(todo.text ?? "unknown")
                }

                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
