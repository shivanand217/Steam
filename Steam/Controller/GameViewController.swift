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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // decodeJSON()
        loadInitialData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Json Parsing
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
                    // print(jsonObj["apps"][i]["name"])
                    // print(jsonObj["apps"][i]["appid"])
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
        // deque the cell to make it reusable
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        cell.textLabel?.text = appIds[indexPath.row]
        
        return cell
    }
    
    func decodeJSON() {
        let Data = Bundle.main.path(forResource: "steamGames", ofType: "json")
        print(Data)
        
        let jsonData: String = (Bundle.main.path(forResource: "steamGames", ofType: "json") as? String)!
        print(jsonData)
        
        /*guard let data = jsonData else {
            print("Error: No data to decode")
            return
        }*/
        
//        guard let games = try? JSONDecoder().decode(Games.self, from: jsonData as ) else {
//            print("Error: Couldn't decode data into Blog.")
//            return
//        }
        
        print("games: ")
        //for _games in games
    }

}
