//  GameModel.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.

import Foundation
import Alamofire

class Game {

    private var _name: String?
    private var _isFree: String?
    private var _type: String?
    private var _requiredAge: String?
    private var _detailedDescription: String?
    private var _aboutGame: String?
    private var _appID: String?
    private var _gameURL: String?
    private var _livePlayersURL: String?
    private var _metacriticScore: String?
    private var _recommendations: String?
    private var _price: String?
    private var _developer: String?
    private var _screenShotURL1: String?
    private var _screenShotURL2: String?
    private var _screenShotURL3: String?
    private var _screenShotURL4: String?
    
    // Getters and Setters
    var screenShotURL1: String {
        set {
            if _screenShotURL1 == nil {
                _screenShotURL1 = ""
            }
        }
        get {
            return _screenShotURL1!
        }
    }
    var screenShotURL2: String {
        set {
            if _screenShotURL2 == nil {
                _screenShotURL2 = ""
            }
        }
        get {
            return _screenShotURL2!
        }
    }
    var screenShotURL3: String {
        set {
            if _screenShotURL3 == nil {
                _screenShotURL3 = ""
            }
        }
        get {
            return _screenShotURL3!
        }
    }
    var screenShotURL4: String {
        set {
            if _screenShotURL4 == nil {
                _screenShotURL4 = ""
            }
        }
        get {
            return _screenShotURL4!
        }
    }
    var type: String {
        set {
            if _type == nil {
                _type = ""
            }
        }
        get {
            return _type!
        }
    }
    var appId: String {
        set {
            if _appID == nil {
                _appID = ""
            }
        }
        get {
            return _appID!
        }
    }
    var developer: String {
        set {
            if _developer == nil {
                _developer = ""
            }
        }
        get {
            return _developer!
        }
    }
    var price: String {
        set {
            if _price == nil {
                _price = ""
            }
        }
        get {
            return _price!
        }
    }
    var name: String {
        set {
            if _name == nil {
                _name = ""
            }
        }
        get {
            return _name!
        }
    }
    var recommendations: String {
        set {
            if _recommendations == nil {
                _recommendations = ""
            }
        }
        get {
            return _recommendations!
        }
    }
    var metacriticScore: String {
        set {
            if _metacriticScore == nil {
                _metacriticScore = ""
            }
        }
        get {
            return _metacriticScore!
        }
    }
    var isFree: String {
        set {
            if _isFree == nil {
                _isFree = ""
            }
        }
        get {
            return _isFree!
        }
    }
    var requiredAge: String {
        set {
            if _requiredAge == nil {
                _requiredAge = ""
            }
        }
        get {
             return _requiredAge!
        }
    }
    var detailedDescription: String {
        set {
            if _detailedDescription == nil {
                _detailedDescription = ""
            }
        }
        get {
            return _detailedDescription!
        }
    }
    var aboutGame: String {
        set {
            if _aboutGame == nil {
                _aboutGame = ""
            }
        }
        get {
            return _aboutGame!
        }
    }
    
    init(name: String, appID: String) {
        self._name = name
        self._appID = appID
        self._gameURL = "\(gameData)\(_appID)"
    }
    
    
}
