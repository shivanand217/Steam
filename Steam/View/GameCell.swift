//
//  GameCell.swift
//  Steam
//
//  Created by apple on 04/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // connect each properties with each cells
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    func configureCell(game: Game) {
        
        thumbImg.image = UIImage()
        gameNameLabel.text = game.name
    }

}
