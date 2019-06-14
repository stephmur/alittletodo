//
//  AddItemViewController.swift
//  ALittleTODO
//
//  Created by Stephen Murphy on 6/14/19.
//  Copyright © 2019 Stephen C. Murphy. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(todoText: String)
}

class AddItemViewController: UIViewController {

    weak var delegate: DataEnteredDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var newItemText: UITextField!
    
    // MARK: - Navigation

    @IBOutlet weak var todoText: UITextField!
    
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func close(_ sender: UIButton) {
        if !(todoText.text ?? "").isEmpty {
            delegate?.userDidEnterInformation(todoText: todoText.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
