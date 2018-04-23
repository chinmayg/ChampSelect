//
//  SearchViewController.swift
//  ChampSelect
//
//  Created by Chinmay Ghotkar on 4/14/18.
//  Copyright © 2018 Chinmay Ghotkar. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    let CurrentVersion = "1.0"
    
    @IBOutlet weak var championSearchBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Trigger an HTTP Request to get all version numbers
        
        // TODO: Find the currrent version (First element of the json)
        
        // TODO: Trigger an HTTP Request to get all champion data if the version has changed
        
        // TODO: Convert JSON into CoreData database
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        // Todo: Trigger an HTTP Request to get detailed champion info
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Functions to generate REST API URLs
    
    // Static Data on All Champions that doesnt have a limit for API calls
    
    func generateURLforAllChampionData(with currentVersion : Int) -> String {
        return "http://ddragon.leagueoflegends.com/cdn/\(currentVersion)/data/en_US/champion.json"
    }
    
    // Get detailed information about a specifc Champion
    
    func generateURLforSpecificChampionData(with championId : Int) -> String {
        return "https://na1.api.riotgames.com/lol/static-data/v3/champions/\(championId)?locale=en_US&champData=allytips&champData=enemytips&champData=passive&champData=spells&api_key=\(Key.Riot.API)"
    }
    
    // Current Version number will be the first element in JSON"
    func generateURLforVersionNumber() -> String {
        return "https://ddragon.leagueoflegends.com/api/versions.json"
    }
    
    // MARK: - Trigger HTTP Request
    func triggerHTTPRequest(with url: String) {
        Alamofire.request(url).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}

