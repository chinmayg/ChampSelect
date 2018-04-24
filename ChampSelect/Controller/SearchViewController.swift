//
//  SearchViewController.swift
//  ChampSelect
//
//  Created by Chinmay Ghotkar on 4/14/18.
//  Copyright © 2018 Chinmay Ghotkar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    var currentVersion = "1.0"
    
    @IBOutlet weak var championSearchBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Need to figure out how to chain multiple HTTP Request
        
        // TODO: Trigger an HTTP Request to get all version numbers
        getVersionDataHTTPRequest()
        
        // TODO: Trigger an HTTP Request to get all champion data if the version has changed
        getStaticChampionDataHTTPRequest()
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
    
    // MARK: - Trigger HTTP Request
    
    // HTTP Request to get all the version numbers for the game
    func getVersionDataHTTPRequest() {
        Alamofire.request(versionDataURL).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value {
                    //print("JSON: \(json)") // serialized json response
                    let versionJSON = JSON(json)
                    
                    // TODO: Find the currrent version (First element of the json)
                    self.currentVersion = versionJSON[0].stringValue
                    
                    print(self.currentVersion)
                }
            }
        }
    }
    
    // HTTP Request to get all champion data request
    func getStaticChampionDataHTTPRequest() {
        Alamofire.request(generateURLforAllChampionData(withVersion: currentVersion)).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value {
                    let allChampionJSON = JSON(json)
                    print(allChampionJSON)
                    
                    // TODO: Covert JSON to database
                }
            }
        }
    }
}

