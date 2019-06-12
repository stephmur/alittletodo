//
//  Document.swift
//  ALittleTODO
//
//  Created by Stephen Murphy on 6/12/19.
//  Copyright © 2019 Stephen C. Murphy. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

