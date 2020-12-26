//
//  summaryTableViewCell.swift
//  Sika
//
//  Created by KWAME DARKO on 8/13/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class summaryTableViewCell: UITableViewCell {
    
    
    @IBOutlet var withdrawn: UILabel!
    
    @IBOutlet var total: UILabel!
    
    @IBOutlet var header2: UILabel!
    
    @IBOutlet var header1: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
