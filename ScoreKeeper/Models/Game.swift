//
//  Game.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import Foundation

class Game: Codable {
    var name: String
    var players: [Player]
    
    init(name: String) {
        self.name = name
        players = []
    }
    
    static var currentGames: [Game] = []
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let gamesArciveURL = documentsDirectory.appendingPathComponent("games").appendingPathExtension("plist")
    
    static func loadGames() {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedGamesData = try? Data(contentsOf: Game.gamesArciveURL), let decodedGames = try? propertyListDecoder.decode(Array<Game>.self, from: retrievedGamesData) {
            Game.currentGames = decodedGames
        }
    }
    
    static func saveGames() {
        let propertyListEncoder = PropertyListEncoder()
        let encodedGames = try? propertyListEncoder.encode(Game.currentGames)
        try? encodedGames?.write(to: Game.gamesArciveURL, options: .noFileProtection)
    }
}
