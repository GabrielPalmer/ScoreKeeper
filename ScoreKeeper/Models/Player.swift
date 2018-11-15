//
//  Player.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import Foundation

class Player: Codable {
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
