//
//  NewGameViewController.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/15/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "openNewGame", sender: nil)
    }
    
    //========================================
    // MARK: - UITextFieldDelegate
    //========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //========================================
    // MARK: - Navigation
    //========================================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = (segue.destination as? UINavigationController)?.viewControllers.first as? PlayersTableViewController else {fatalError("Unexpected Segue Destination")}
        
        var name = nameTextField.text ?? ""
        if name.isEmpty {
            name = "<no name>"
        }
        
        let game = Game(name: name)
        Game.currentGames.insert(game, at: 0)
        destination.game = game
        destination.navigationItem.title = name
    }

}
