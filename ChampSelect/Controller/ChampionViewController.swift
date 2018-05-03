//
//  ChampionViewController.swift
//  ChampSelect
//
//  Created by Chinmay Ghotkar on 4/14/18.
//  Copyright © 2018 Chinmay Ghotkar. All rights reserved.
//

import UIKit



class ChampionViewController: UIViewController {
    
    var championId : String = "0" // This value will be set by previous view controller
    @IBOutlet weak var tempChampionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempChampionLabel.text = championId
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
