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
    
    let champ_list : String = "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=all&dataById=false&api_key="
    let champ_detail : String = "https://na1.api.riotgames.com/lol/static-data/v3/champions/{}?locale=en_US&tags=all&api_key="
    
    @IBOutlet weak var championSearchBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(Key.Riot.API)
    }
    
}

