//  GameViewController.swift
//  Steam
//
//  Created by apple on 03/07/18.
//  Copyright © 2018 shiv. All rights reserved.

import UIKit
import SwiftyJSON
import Alamofire
import GoogleSignIn
import ProgressHUD

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Store all the app id's
    var appIds: [String] = []
    
    var filteredAppIds: [String] = []
    
    // all info corresponding to all the appIDs
    var games : [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadInitialData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    
    func filterAppIDs() {
        var url = "\(gameData)"
        
        for item in appIds {
            url = "\(gameData)"
            url += item
            Alamofire.request(url, method: .get).responseJSON { (response) in
                if let data = response.result.value as? Dictionary<String, Any> {
                    if let data1 = data[item] as? Dictionary<String, Any> {
                        if let data2 = data1["data"] as? Dictionary<String, Any> {
                            if data2["type"] as? String == "game" {
                                self.filteredAppIds.append(item)
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
        
        var url_path = "\(gameData)"
        url_path += appIds[indexPath.row]
        let item = appIds[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameCell {
            
            cell.configureCell(appID: item)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gameDetailViewController", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        ProgressHUD.showSuccess("Successfully signedOut.", interaction: false)
        GIDSignIn.sharedInstance().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameDetailViewController" {
            if let detailsVC = segue.destination as? GameDetailViewController {
                detailsVC.passedValueCell = sender as? GameCell
            }
        }
    }
    
    
}
