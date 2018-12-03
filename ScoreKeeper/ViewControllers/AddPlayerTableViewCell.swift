//
//  AddPlayerTableViewCell.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class AddPlayerTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
    }
    
    //========================================
    // MARK: - UITextFieldDelegate
    //========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
