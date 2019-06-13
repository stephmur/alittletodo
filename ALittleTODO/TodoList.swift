//
//  TodoList.swift
//  ALittleTODO
//
//  Created by Stephen Murphy on 6/12/19.
//  Copyright © 2019 Stephen C. Murphy. All rights reserved.
//

import Foundation

struct TodoList: Codable
{
    var todos = [TodoItem]()
    
    struct TodoItem: Codable {
        var complete: Bool?
        var text: String?
    }
    
    init?(json: Data) // try to init a TodoList from some JSON
    {
        if let newValue = try? JSONDecoder().decode(TodoList.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    var json: Data? // return this TodoList as a JSON data
    {
        return try? JSONEncoder().encode(self)
    }
}
