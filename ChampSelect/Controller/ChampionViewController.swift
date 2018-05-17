//
//  ChampionViewController.swift
//  ChampSelect
//
//  Created by Chinmay Ghotkar on 4/14/18.
//  Copyright © 2018 Chinmay Ghotkar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChampionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var abilityArray : [Ability] = [Ability]()
    var abilityKeyBind : [String] = ["P", "Q", "W", "E","R"]
    var championId : String = "0" // This value will be set by previous view controller

    @IBOutlet weak var championNameLabel: UILabel!
    @IBOutlet weak var championAbilityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view controller as delegate and datasource
        
        championAbilityTable.delegate = self
        championAbilityTable.dataSource = self
        
        championNameLabel.adjustsFontSizeToFitWidth = true
        
        getChampionDataWithHTTPReqest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - Champion Ability Info Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abilityArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customAbilityCell", for: indexPath) as! ChampAbilityCell
        cell.AbilityDesc.text = abilityArray[indexPath.row].abilityDesc
        cell.AbilityKey.text = abilityKeyBind[indexPath.row]
        cell.AbilityName.text = abilityArray[indexPath.row].abilityName
        
        return cell
    }
    
    // MARK : - Get Champion Info
    
    func getChampionDataWithHTTPReqest() {
        Alamofire.request(generateURLforSpecificChampionData(withId: championId)).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value {
                    let championJSON = JSON(json)
                    //print(championJSON)
                    self.championNameLabel.text = championJSON["name"].string
                    
                    // Get Passive
                    let passiveSubJSON = championJSON["passive"]
                    //print(passiveSubJSON)
                    let newAbility = Ability()
                    newAbility.abilityName = passiveSubJSON["name"].string!
                    newAbility.abilityDesc = passiveSubJSON["description"].string!
                    self.abilityArray.append(newAbility)
                    
                    // Get the other 4 abilities
                   
                    let spellSubJSON = championJSON["spells"]
                    
                    for index in 0...3 {
                        for (_, spellJSON):(String, JSON) in spellSubJSON[index]{
                            print("*****************SPELL \(index) ***************")
                            print(spellJSON)
                            let newAbility = Ability()
                            newAbility.abilityName = spellJSON["name"].string!
                            newAbility.abilityDesc = spellJSON["description"].string!
                            self.abilityArray.append(newAbility)
                            print(newAbility.abilityName)
                            print(newAbility.abilityDesc)
                            print("*****************SPELL \(index) ***************")
                        }
                    }

                }
            }
        }
    }
}
