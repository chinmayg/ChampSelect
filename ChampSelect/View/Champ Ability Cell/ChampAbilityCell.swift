//
//  ChampAbilityCell.swift
//  ChampSelect
//
//  Created by Chinmay Ghotkar on 5/9/18.
//  Copyright © 2018 Chinmay Ghotkar. All rights reserved.
//

import UIKit

class ChampAbilityCell: UITableViewCell {

    @IBOutlet weak var AbilityKey: UILabel!
    @IBOutlet weak var AbilityDesc: UILabel!
    @IBOutlet weak var AbilityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
