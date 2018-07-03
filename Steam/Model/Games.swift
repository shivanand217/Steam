//
//  Games.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import Foundation

struct Games: Decodable {
    
    // array of games
    let games: [app]
    
    enum CodingKeys: String, CodingKey {
        case games = "apps"
    }
}

struct app: Decodable {
    
    let appId: String!
    let name: String!
    
    enum CodingKeys: String, CodingKey {
        case name
        case appId = "appid"
    }
}
