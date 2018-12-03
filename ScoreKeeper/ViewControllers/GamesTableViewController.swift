//
//  GamesTableViewController.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Game.loadGames()
    }

    //========================================
    // MARK: - Table view data source
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.currentGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        cell.textLabel?.text = Game.currentGames[indexPath.row].name
        cell.detailTextLabel?.text = "\(Game.currentGames[indexPath.row].players.count) Players"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Game.currentGames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Game.saveGames()
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "newGameSegue", sender: nil)
    }

    //========================================
    // MARK: - Navigation
    //========================================
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        switch segue.identifier {
        case "editGameSegue":
            guard let destination = segue.destination as? PlayersTableViewController else {fatalError("Unexpected Segue Destination")}
            
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                destination.game = Game.currentGames[selectedRow]
                destination.navigationItem.title = Game.currentGames[selectedRow].name
            } else {
                fatalError("editGameSegue was called but no row was selected")
            }
            
        case "newGameSegue":
            break
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    @IBAction func unwindToGamesTableViewController(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

}
