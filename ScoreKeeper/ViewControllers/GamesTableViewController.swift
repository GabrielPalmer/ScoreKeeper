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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "newGameSegue", sender: nil)
    }
    
    //========================================
    // MARK: - Navigation
    //========================================
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        switch segue.identifier {
        case "editGameSegue":
            guard let destination = (segue.destination as? UINavigationController)?.viewControllers.first as? PlayersTableViewController else {fatalError("Unexpected Segue Destination")}
            
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
