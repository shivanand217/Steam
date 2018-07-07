//  GameDetailViewController.swift
//  Steam
//
//  Created by apple on 04/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import GoogleSignIn

class GameDetailViewController: UIViewController {
    
    var passedValueCell: GameCell!
    
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
    @IBOutlet weak var aboutGameText: UITextView!
    
    // Four screenshots taken
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot3: UIImageView!
    
    var screenUrl1: String!
    var screenUrl2: String!
    var screenUrl3: String!
    var screenUrl4: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadAndUpdateData()
    }
    
    func downloadAndUpdateData() {
        
        var url_path = "\(gameData)"
        let appId = passedValueCell.appId.description
        
        url_path += "\(appId)"
        // print("url_path is: \(url_path)")
        
        Alamofire.request(url_path, method: .get).responseJSON { (response) in
            
            if let data = response.result.value as? Dictionary<String, Any> {
                
                if let data1 = data[self.passedValueCell.appId] as? Dictionary<String, Any> {
                    
                    if let data2 = data1["data"] as? Dictionary<String, Any> {
                        
                        // Check if the type of this appId is game
                        if data2["type"] as? String == "game" {
                            
                            /** Details data **/
                            var screenShotURL1 = ""
                            var screenShotURL2 = ""
                            var screenShotURL3 = ""
                            var screenShotURL4 = ""
                            var developer = ""
                            var price: String!
                            var metacritic: String!
                            var recommendations: String!
                            
                            let type = data2["type"] as! String
                            let name = data2["name"] as! String
                            let appid = "\(data2["steam_appid"] as! Int)"
                                
                            let age = data2["required_age"] as! Int
                            let free = data2["is_free"] as! Bool
                            let description = data2["detailed_description"] as! String
                            let aboutGame = data2["about_the_game"] as! String
                            let imageURL = data2["header_image"] as! String
                            if let dev = data2["developers"] as? [String] {
                                developer = dev[0]
                            }
                            if let _price = data2["price_overview"] as? Dictionary<String, Any> {
                                price = "\(_price["final"] as! Int)"
                            }
                            if let _metacritic = data2["metacritic"] as? Dictionary<String, Any> {
                                metacritic = "\(_metacritic["score"] as! Int)"
                            }
                            
                            if let screenShots = data2["screenshots"] as? [Dictionary<String, Any>] {
                                var i = 0
                                for screen in screenShots {
                                    if let _screen = screen as? Dictionary<String, Any> {
                                        if i == 0 {
                                            screenShotURL1 = screen["path_thumbnail"] as! String
                                        } else if i == 1 {
                                            screenShotURL2 = screen["path_thumbnail"] as! String
                                        } else if i == 2 {
                                            screenShotURL3 = screen["path_thumbnail"] as! String
                                        } else {
                                            screenShotURL4 = screen["path_thumbnail"] as! String
                                        }
                                    }
                                    i += 1
                                }
                            }
                            if let recom = data2["recommendations"] as? Dictionary<String, Any> {
                                recommendations = "\(recom["total"] as! Int)"
                            }
                            
                            let Description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                            let About = aboutGame.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                            
                            /** Update UI **/
                            self._developerLbl.text = developer
                            self._priceLbl.text = price
                            if metacritic == nil {
                                self._metacriticScoreLbl.text = "NA"
                            } else {
                                self._metacriticScoreLbl.text = metacritic
                            }
                            self._recommendationLbl.text = recommendations
                            self._nameLbl.text = name
                            self._gameIDLbl.text = appid
                            if age == 0 {
                                self._requiredAgeLbl.text = "NA"
                            } else {
                                self._requiredAgeLbl.text = "\(age)"
                            }
                            if free == false {
                                self._isFreeLbl.text = "NO"
                            } else {
                                self._isFreeLbl.text = "YES"
                            }
                            self._descriptionText.text = Description
                            self.aboutGameText.text = About
                            
                            /** Update Images **/
                            Alamofire.request(screenShotURL1, method: .get).responseImage { (response) in
                                if let image = response.result.value {
                                    self.screenShot1.image = image
                                } else {
                                    self.screenShot1.image = UIImage(named: "batman")
                                }
                            }
                            Alamofire.request(screenShotURL2, method: .get).responseImage { (response) in
                                if let image = response.result.value {
                                    self.screenShot2.image = image
                                } else {
                                    self.screenShot2.image = UIImage(named: "batman")
                                }
                            }
                            Alamofire.request(screenShotURL3, method: .get).responseImage { (response) in
                                if let image = response.result.value {
                                    self.screenShot3.image = image
                                } else {
                                    self.screenShot3.image = UIImage(named: "batman")
                                }
                            }
                            Alamofire.request(imageURL, method: .get).responseImage(completionHandler: { (response) in
                                if let image = response.result.value {
                                    self._mainImg.image = image
                                } else {
                                    self._mainImg.image = UIImage(named: "batman")
                                }
                            })
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
