//
//  GameDetailViewController.swift
//  Steam
//
//  Created by apple on 04/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    var game: Game!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var isFreeLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var metacriticLbl: UILabel!
    @IBOutlet weak var recommendationLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var developerLbl: UILabel!
    // Four screenShots
    @IBOutlet weak var screen1: UIImageView!
    @IBOutlet weak var screen2: UIImageView!
    @IBOutlet weak var screen3: UIImageView!
    @IBOutlet weak var screen4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        game.downloadGameDetails {
//            self.updateUI()
//        }
    }
    
    func updateUI() {
        
        nameLbl.text = "\(game.name)"
        if game.isFree == "true" {
            isFreeLbl.text = "NO"
        } else {
            isFreeLbl.text = "YES"
        }
        
        ageLbl.text = "\(game.requiredAge)"
        descriptionLabel.text = "\(game.detailedDescription)"
        aboutLbl.text = "\(game.aboutGame)"
        idLbl.text = "\(game.appId)"
        metacriticLbl.text = "\(game.metacriticScore)"
        recommendationLbl.text = "\(game.recommendations)"
        priceLbl.text = "\(game.price)"
        developerLbl.text = "\(game.developer)"
        
    }

}
