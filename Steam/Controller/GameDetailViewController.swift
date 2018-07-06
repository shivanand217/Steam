//
//  GameDetailViewController.swift
//  Steam
//
//  Created by apple on 04/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import Alamofire

class GameDetailViewController: UIViewController {
    
    var appid: String!
    
    @IBOutlet weak var _nameLbl: UILabel!
    @IBOutlet weak var _mainImg: UIImageView!
    @IBOutlet weak var _requiredAgeLbl: UILabel!
    @IBOutlet weak var _isFreeLbl: UILabel!
    @IBOutlet weak var _gameIDLbl: UILabel!
    @IBOutlet weak var _priceLbl: UILabel!
    @IBOutlet weak var _metacriticScoreLbl: UILabel!
    @IBOutlet weak var _recommendationLbl: UILabel!
    @IBOutlet weak var _developerLbl: UILabel!
    @IBOutlet weak var _descriptionText: UITextView!
    
    // four screenshots taken
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot23: UIImageView!
    @IBOutlet weak var screenShot4: UIImageView!
    @IBOutlet weak var aboutGameText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func downloadData() {
        
        var url_path = "\(gameData)"
        url_path = url_path + appid
        
        Alamofire.request(url_path, method: .get).responseJSON { (response) in
            
            if let data = response.result.value as? Dictionary<String, Any> {
                
                if let data1 = data[self.appid] as? Dictionary<String, Any> {
                    
                    if let data2 = data1["data"] as? Dictionary<String, Any> {
                        
                        // check if the type of this appId is game
                        if data2["type"] as? String == "game" {
                            
                            let name = (data2["name"] as? String)!
                            let appID = self.appid
                            
                            
                            
                            _game.requiredAge = "12"
                            
                            if data2["is_free"] as? Bool == false {
                                _game.isFree = "false"
                            } else {
                                _game.isFree = "true"
                            }
                            _game.isFree = "false"
                            
                            _game.detailedDescription = (data2["detailed_description"] as? String)!
                            _game.aboutGame = (data2["about_the_game"] as? String)!
                            
                            if let data3 = data2["developers"] as? [String] {
                                _game.developer = data3[0]
                            }
                            
                            if let price_detail = data2["price_overview"] as? Dictionary<String, Any> {
                                _game.price = "1276"
                            }
                            
                            if let metacritic = data2["metacritic"] as? Dictionary<String, Any> {
                                _game.metacriticScore = "21"
                            }
                            
                            var i = 0
                            if let screenShots = data2["screenshots"] as? [Dictionary<String, Any>] {
                                for screen in screenShots {
                                    if i == 0 {
                                        _game.screenShotURL1 = (screen["path_thumbnail"] as? String)!
                                    } else if i == 1 {
                                        _game.screenShotURL2 = (screen["path_thumbnail"] as? String)!
                                    } else if i == 2 {
                                        _game.screenShotURL3 = (screen["path_thumbnail"] as? String)!
                                    } else {
                                        _game.screenShotURL4 = (screen["path_thumbnail"] as? String)!
                                    }
                                    i += 1
                                }
                            }
                            
                            _game.recommendations = "ok."
                            
                            //self.games.append(_game)
                        }
                    }
                }
            }
        }
    }

}
