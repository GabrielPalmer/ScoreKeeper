//
//  PlayerTableViewCell.swift
//  ScoreKeeper
//
//  Created by Gabriel Blaine Palmer on 11/14/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
