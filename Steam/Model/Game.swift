//  GameModel.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.

import Foundation
import Alamofire

class Game {

    private var _name: String!
    private var _isFree: Bool!
    private var _type: String!
    private var _requiredAge: Int!
    private var _detailedDescription: String!
    private var _aboutGame: String!
    private var _appID: String!
    private var _gameURL: String!
    private var _livePlayersURL: String!
    private var _metacriticScore: String!
    private var _recommendations: String!
    private var _price: String!
    private var _developer: String!
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var appId: String {
        if _appID == nil {
            _appID = ""
        }
        return _appID
    }
    
    var developer: String {
        if _developer == nil {
            _developer = ""
        }
        return _developer
    }
    
    var price: String {
        if _price == nil {
            _price = ""
        }
        return _price
    }
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var recommendations: String {
        if _recommendations == nil {
            _recommendations = ""
        }
        return _recommendations
    }
    
    var metacriticScore: String {
        if _metacriticScore == nil {
            _metacriticScore = ""
        }
        return _metacriticScore
    }
    
    var isFree: Bool {
        return _isFree
    }
    
    var requiredAge: Int {
        return _requiredAge
    }
    
    var detailedDescription: String {
        if _detailedDescription == nil {
            _detailedDescription = ""
        }
        return _detailedDescription
    }
    
    var aboutGame: String {
        if _aboutGame == nil {
            _aboutGame = ""
        }
        return _aboutGame
    }
    
    init(name: String, appID: String) {
        self._name = name
        self._appID = appID
        self._gameURL = "\(API_1)\(_appID)"
    }
    
    func downloadGameDetails(completed: @escaping DownloadCompleted) {
        
        Alamofire.request(self._gameURL, method: .get).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let content = dict["\(self._appID)"] as? Dictionary<String, AnyObject> {
                    print(content)
                    if let gameData = content["data"] as? Dictionary<String, AnyObject> {
                        print(gameData)
                    }
                }
            }
            
            completed()
        }
    }
    
}
