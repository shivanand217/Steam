//  GameViewController.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if games[indexPath.row].type == "game" {
            // deque the cell to make it reusable
            if let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? Game {
                
                var game : Game!
                game = games[indexPath.row]
                
                cell.conigureCell(game)
                
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
    
    // show details
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
            if let detailsVC = segue.destination as? GameDetailVC {
                if let game = sender as? Game {
                    detailsVC.game = game
                }
            }
        }
    }
    
}
