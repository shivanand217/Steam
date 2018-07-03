//
//  GameModel.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import Foundation

class Game {

    private var _name: String!
    private var _isFree: Bool!
    private var _requiredAge: Int!
    private var _detailedDescription: String!
    private var _aboutGame: String!
    private var _imageURL: String!
    private var _appID: String!
    private var _gameURL: String!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
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
    
    var imageURL: String {
        if _imageURL == nil {
            _imageURL = ""
        }
        return _imageURL
    }
    
    init(name: String, appID: String) {
        self._name = name
        self._appID = appID
        self._gameURL = "\(API_1)\(_appID)"
    }
    
    func downloadGameDetails(completed: @escaping DownloadCompleted) {
        
        
        
    }
    
}
