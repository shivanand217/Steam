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
    @IBOutlet weak var gameNameLbl: UILabel!
    @IBOutlet weak var playersOnline: UILabel!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        let color = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
//        
//        layer.borderColor = color.cgColor
//        layer.cornerRadius = 9.0
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configure cells with game item
    func configureCell(appID: String) {
        
        let imageUrl = "\(image_BASE_URL)\(appID)\(header)"
        Alamofire.request(imageUrl, method: .get).responseImage { (response) in
            print("image request")
            if let image = response.result.value {
                self.thumbImg.image = image as? UIImage
            } else {
                self.thumbImg.image = UIImage(named: "batman")
            }
        }

        let playersOnlineUrl = "\(playerOnline)\(appID)"
        Alamofire.request(playersOnlineUrl, method: .get).responseJSON { (response) in
            if let data = response.result.value as? Dictionary<String, Any> {

                if let data1 = data["response"] as? Dictionary<String, Any> {

                    if let player_count = data1["player_count"] as? Int {
                        print("player count: \(player_count)")
                        self.playersOnline.text = "\(player_count)"
                    }
                }
            }
        }

        let path = "\(gameData)\(appID)"
        Alamofire.request(path, method: .get).responseJSON { (response) in

            if let data = response.result.value as? Dictionary<String, Any> {
                if let data1 = data[appID] as? Dictionary<String, Any> {
                    if let data3 = data1["data"] as? Dictionary<String, Any> {
                        self.gameNameLbl.text = data3["name"] as? String
                    }
                }
            }
        }
        
    }

}
