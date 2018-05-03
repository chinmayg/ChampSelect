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
import CoreData

class SearchViewController: UIViewController {
    
    var currentVersion = "8.9.1" // Manually Change until I get Promise Pattern working
    // created a reference to app delegate to the context for the persistent container
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext?
    
    @IBOutlet weak var championSearchBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        championSearchBar.clearsOnBeginEditing = true
        // find the sqlite database
        //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        //print(dataFilePath)
        // context from the container
        context = appDelegate.persistentContainer.viewContext
        
        // TODO: Need to figure out how to chain multiple HTTP Request
        
        // TODO: Trigger an HTTP Request to get all version numbers
        //getVersionDataHTTPRequest()
        
        // MARK: Trigger an HTTP Request to get all champion data if the version has changed
        //getStaticChampionDataHTTPRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToChampionInfo" {
            if let destinationVC = segue.destination as? ChampionViewController {
                destinationVC.championId = findChampionInData(withChampionName: championSearchBar.text!)
            }
        }
    }
    
    // MARK: - Trigger HTTP Request
    
    // HTTP Request to get all the version numbers for the game
//    func getVersionDataHTTPRequest() {
//        Alamofire.request(versionDataURL).responseJSON { response in
//            if response.result.isSuccess {
//                if let json = response.result.value {
//                    //print("JSON: \(json)") // serialized json response
//                    let versionJSON = JSON(json)
//
//                    // TODO: Find the currrent version (First element of the json)
//                    self.currentVersion = versionJSON[0].stringValue
//
//                    print(self.currentVersion)
//                }
//            }
//        }
//    }
    
    // HTTP Request to get all champion data request
    func getStaticChampionDataHTTPRequest() {
        Alamofire.request(generateURLforAllChampionData(withVersion: currentVersion)).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value {
                    let allChampionJSON = JSON(json)
                    // print(allChampionJSON)
                    
                    // MARK: Covert JSON to database
                    // loops through the static champion data
                    // for every champion, for loop will return key (which is ignored hence the _) and subJSON
                    for (_, subChampionJson):(String, JSON) in allChampionJSON["data"] {
                        //print(key)
                        //print(subChampionJson)
                        
                        // add champion to core data
                        self.addChampionData(withName: subChampionJson["name"].string!.lowercased(), withChampionID: subChampionJson["key"].string!)
                        // save core data
                        self.saveData()
                    }
                }
            }
        }
    }
    
    //MARK: - Core Data Functions
    
    // adds the Champion data to persistent database
    func addChampionData(withName: String, withChampionID: String) {
        
        //print("Champion Name: \(withName)")
        //print("Champion ID: \(withChampionID)")
        
        // create an entity
        let entity = NSEntityDescription.entity(forEntityName: "Champion", in: context!)
        
        let newChampionData = NSManagedObject(entity: entity!, insertInto: context!)
        
        // set the attributes of the champion object
        newChampionData.setValue(withName, forKey: "name")
        newChampionData.setValue(withChampionID, forKey: "champId")
    }
    
    // saves the core data
    func saveData() {
        do {
            try context!.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // query the core data table for the champion name
    func findChampionInData(withChampionName: String) -> String {
        //print(withChampionName)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Champion")
        request.predicate = NSPredicate(format: "name = %@", withChampionName.lowercased())
        
        do {
            let result = try context?.fetch(request)

            for data in result as! [NSManagedObject] {
                let championName = data.value(forKey: "name") as! String
                let championID = data.value(forKey: "champId") as! String
                //print(championName)
                return championID
            }
        } catch {
            print("Couldnt find the champion name")
        }
        
        return ""
    }
    
}

