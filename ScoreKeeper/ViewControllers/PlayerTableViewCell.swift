//
//  PlayerTableViewCell.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: PlayersTableViewController?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    @IBOutlet weak var scoreTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scoreTextField.delegate = self
        scoreTextField.borderStyle = .none
 
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scoreStepper.isEnabled = false
        scoreStepper.tintColor = UIColor.gray
        scoreTextField.borderStyle = .roundedRect
        scoreTextField.selectAll(nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scoreTextField.resignFirstResponder()
        scoreTextField.borderStyle = .none
        scoreStepper.isEnabled = true
        scoreStepper.tintColor = #colorLiteral(red: 0, green: 0.4901960784, blue: 0.9764705882, alpha: 1)
        
        if let score = Int(scoreTextField.text ?? "") {
            
            if Double(score) > scoreStepper.maximumValue {
                scoreStepper.value = scoreStepper.maximumValue
                delegate?.scoreStepperChanged(scoreStepper)
            } else {
                scoreStepper.value = Double(score)
                delegate?.scoreStepperChanged(scoreStepper)
            }
        } else {
            scoreTextField.text = String(Int(scoreStepper.value))
        }
        return true
    }
}
