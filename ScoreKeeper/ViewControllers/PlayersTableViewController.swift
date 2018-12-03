//
//  PlayersTableViewController.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {

    var game: Game? 
    var addingNewPlayer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //========================================
    // MARK: - Actions
    //========================================
    
    @IBAction func backButtonTapped(_ sender: Any) {
        Game.saveGames()
        performSegue(withIdentifier: "unwindToGamesTableViewController", sender: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        addingNewPlayer = true
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? AddPlayerTableViewCell {
            cell.nameTextField.text = ""
            cell.nameTextField.becomeFirstResponder()
        }
        
        Game.saveGames()
        
    }
    
    @objc func cellAddButtonTapped() {
        addingNewPlayer = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! AddPlayerTableViewCell
        
        var name = cell.nameTextField.text ?? ""
        if name.isEmpty {
            name = "<no name>"
        }
        
        game!.players.insert(Player(name: name, score: 0), at: 0)
        
        Game.saveGames()
        tableView.reloadData()
    }
    
    @objc func cellCancelButtonTapped() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        if let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? AddPlayerTableViewCell {
            cell.nameTextField.resignFirstResponder()
        }
        addingNewPlayer = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @objc func scoreStepperChanged(_ sender: UIStepper) {
        let cell = tableView.cellForRow(at: IndexPath(item: sender.tag, section: 0)) as! PlayerTableViewCell

        game!.players[sender.tag - 1].score = Int(sender.value)
        cell.scoreTextField.text = String(game!.players[sender.tag - 1].score)
    }
    
    //========================================
    // MARK: - Table view data source
    //========================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game!.players.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "newPlayerCell", for: indexPath) as! AddPlayerTableViewCell
            
            cell.selectionStyle = .none
            
            cell.addButton.addTarget(self, action: #selector(cellAddButtonTapped), for: .touchUpInside)
            cell.cancelButton.addTarget(self, action: #selector(cellCancelButtonTapped), for: .touchUpInside)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
            
            cell.delegate = self
            cell.selectionStyle = .none
            
            cell.scoreStepper.tag = indexPath.row
            cell.scoreStepper.addTarget(self, action: #selector(scoreStepperChanged(_:)), for: .valueChanged)
            
            cell.nameLabel.text = game!.players[indexPath.row - 1].name
            cell.scoreTextField.text = String(game!.players[indexPath.row - 1].score)
            cell.scoreStepper.value = Double(game!.players[indexPath.row - 1].score)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (addingNewPlayer ? 44 : 0)
        } else {
            return 44
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            game!.players.remove(at: indexPath.row - 1)
            Game.saveGames()
            tableView.reloadData() //required to update stepper tags
            
        }
    }
    
     //========================================
     // MARK: - Navigation
     //========================================
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Game.saveGames()
     }

}
