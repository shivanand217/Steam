//
//  GameDetailViewController.swift
//  Steam
//
//  Created by apple on 04/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GameDetailViewController: UIViewController {
    
    var passedValue: String = ""
    
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
    @IBOutlet weak var screenShot23: UIImageView!
    @IBOutlet weak var screenShot4: UIImageView!
    
    var screenUrl1: String!
    var screenUrl2: String!
    var screenUrl3: String!
    var screenUrl4: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("passedvalue: \(passedValue)")
        
        //downloadAndUpdateData()
        //updateScreenShots()
    }
    
    func downloadAndUpdateData() {
        
        var url_path = "url is burr: \(gameData)"
        print(url_path)
        
        Alamofire.request(url_path, method: .get).responseJSON { (response) in
            
            if let data = response.result.value as? Dictionary<String, Any> {
                
                if let data1 = data[self.passedValue] as? Dictionary<String, Any> {
                    
                    if let data2 = data1["data"] as? Dictionary<String, Any> {
                        
                        // Check if the type of this appId is game
                        if data2["type"] as? String == "game" {
                            
                            let name = (data2["name"] as? String)!
                            let appID = self.passedValue
                            
                            self._nameLbl.text = name
                            
                            self._gameIDLbl.text = appID
                            
                            self._requiredAgeLbl.text = "\(String(describing: data["required_age"]))"
                            
                            if data2["is_free"] as? Bool == false {
                                self._isFreeLbl.text = "NO"
                            } else {
                                self._isFreeLbl.text = "YES"
                            }
                            
                            self._descriptionText.text = "\(String(describing: data["detailed_description"]))"
                            
                            self.aboutGameText.text = "\(String(describing: data["about_the_game"]))"
                            
                            if let data3 = data2["developers"] as? [String] {
                                self._developerLbl.text = "\(data3[0])"
                            }
                            
                            if let price_detail = data2["price_overview"] as? Dictionary<String, Any> {
                                self._priceLbl.text = "\(String(describing: price_detail["final"]))"
                            }
                            
                            if let metacritic = data2["metacritic"] as? Dictionary<String, Any> {
                                self._metacriticScoreLbl.text = "\(String(describing: metacritic["score"]))"
                            }
                            
                            var i = 0
                            if let screenShots = data2["screenshots"] as? [Dictionary<String, Any>] {
                                for screen in screenShots {
                                    if i == 0 {
                                        self.screenUrl1 = "\(String(describing: screen["path_thumbnail"]))"
                                    } else if i == 1 {
                                        self.screenUrl2 = "\(String(describing: screen["path_thumbnail"]))"
                                    } else if i == 2 {
                                        self.screenUrl3 = "\(String(describing: screen["path_thumbnail"]))"
                                    } else {
                                        self.screenUrl4 = "\(String(describing: screen["path_thumbnail"]))"
                                    }
                                    i += 1
                                }
                            }
                            
                            if let recommendations = data2["recommendations"] as? Dictionary<String, Any> {
                                self._recommendationLbl.text = "\(String(describing: recommendations["total"]))"
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateScreenShots() {
        
        // Four Requests for Screenshots
        Alamofire.request(screenUrl1, method: .get).responseImage { (response) in
            if let image = response.result.value {
                self.screenShot1.image = image
            } else {
                self.screenShot1.image = UIImage(named: "batman")
            }
        }
        Alamofire.request(screenUrl2, method: .get).responseImage { (response) in
            if let image = response.result.value {
                self.screenShot2.image = image
            } else {
                self.screenShot2.image = UIImage(named: "batman")
            }
        }
        Alamofire.request(screenUrl3, method: .get).responseImage { (response) in
            if let image = response.result.value {
                self.screenShot23.image = image
            } else {
                self.screenShot23.image = UIImage(named: "batman")
            }
        }
        Alamofire.request(screenUrl4, method: .get).responseImage { (response) in
            if let image = response.result.value {
                self.screenShot4.image = image
            } else {
                self.screenShot4.image = UIImage(named: "batman")
            }
        }
        
    }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
