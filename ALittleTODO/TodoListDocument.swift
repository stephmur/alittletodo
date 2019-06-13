//
//  TodoListDocument.swift
//  ALittleTODO
//
//  Created by Stephen Murphy on 6/12/19.
//  Copyright © 2019 Stephen C. Murphy. All rights reserved.
//

import UIKit

class TodoListDocument: UIDocument {
    
    var todoList: TodoList?
    
    override func contents(forType typeName: String) throws -> Any {
        return todoList?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let json = contents as? Data {
            todoList = TodoList(json: json)
        }
    }
}

