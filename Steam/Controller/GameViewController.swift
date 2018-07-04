//  GameViewController.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.

import UIKit
import SwiftyJSON
import Alamofire

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // store all the app id's
    var appIds: [String] = []
    
    // all info corresponding to all the appIDs
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadInitialData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ParseJson
    func loadInitialData() {
        
        guard let fileName = Bundle.main.path(forResource: "steamGames", ofType: "json")
            else { return }
        
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String: Any],
            let app = dictionary["apps"] as? [Any]
            else { return }
        
        if let path = Bundle.main.path(forResource: "steamGames", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                for var i in (0..<jsonObj["apps"].count) {
                    appIds.append("\(jsonObj["apps"][i]["appid"])")
                }
                
            } catch let error {
                print("parse error.")
            }
            
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func downloadGameData() {
        
        var url_path = "\(gameData)"
        
        // Download data for all the games having type as game
        for item in appIds {
            
            url_path += "\(item)"
            // make the request
            Alamofire.request(url_path, method: .get).responseJSON { (response) in
                
                if let data = response.result.value as? Dictionary<String, Any> {
                    
                    if let data1 = data["\(item)"] as? Dictionary<String, Any> {
                        
                        if let data2 = data1["data"] as? Dictionary<String, Any> {
                            
                            // check if the type of this appId is game
                            if data2["type"] as? String == "game" {
                                // download the data
                                var _game: Game!
                                
                                _game.name = data2["name"] as? String
                                _game.appId = "\(item)"
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if games[indexPath.row].type == "game" {
            // deque the cell to make it reusable
            if let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? Game {
                
                var game : Game!
                game = games[indexPath.row]
                
                cell.configureCell(game)
                
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
    
    // Show details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var game: Game!
        game = games[indexPath.row]
        performSegue(withIdentifier: "gameDetailViewController", sender: game)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Send the data through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gameDetailViewController" {
            if let detailsVC = segue.destination as? GameDetailViewController {
                if let game = sender as? Game {
                    detailsVC.game = game
                }
            }
        }
    }
    
}
