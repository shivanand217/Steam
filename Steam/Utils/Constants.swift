//  Constants.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.

import Foundation

// API's
let gameData = "http://store.steampowered.com/api/appdetails/?appids="
let playerOnline = "https://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v1/?appid="

let header: String = "/header.jpg"
let image_BASE_URL: String = "https://steamcdn-a.akamaihd.net/steam/apps/"

let screenshot_BASE_URL = ""

typealias DownloadCompleted = () -> ()
