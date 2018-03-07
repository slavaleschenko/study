//
//  RidersCell.swift
//  MotoRiders
//
//  Created by Admin on 07.03.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class RidersCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var bikeAndNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
