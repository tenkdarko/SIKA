//
//  ReferralCell.swift
//  Sika
//
//  Created by KWAME DARKO on 10/23/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class ReferralCell: UITableViewCell {
    
    
    @IBOutlet var youInvited: UILabel!
    
    @IBOutlet var coinsMade: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
