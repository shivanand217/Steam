//  GameCell.swift
//  Steam
//
//  Created by apple on 04/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GameCell: UITableViewCell {

    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var playersOnline: UILabel!
    
    var game: Game!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let color = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        layer.borderColor = color.cgColor
        layer.cornerRadius = 9.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configure cells with game item
    func configureCell(game: Game) {
        
        let imageUrl = "\(image_BASE_URL)\(game.appId)\(header)"
        
        Alamofire.request(imageUrl, method: .get).responseImage { (response) in
            guard let image = response.result.value else {
                self.thumbImg.image = UIImage()
                return
            }
            self.thumbImg.image = image
        }
        
        let playersOnlineUrl = "\(playerOnline)\(game.appId)"
        print(playersOnlineUrl)
        
        // get players online
        Alamofire.request(playersOnlineUrl, method: .get).responseJSON { (response) in
            
        }
        
        gameNameLabel.text = game.name
        
    }

}
