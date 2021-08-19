//
//  walletTableViewCell.swift
//  Sika
//
//  Created by KWAME DARKO on 8/13/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

struct walletBottom{
    var image = ""
    var header = ""
    var message = ""
}

class walletTableViewCell: UITableViewCell {
 
    @IBOutlet var buttonLink: RoundButton!
    
    @IBOutlet var imageHere: UIImageView!
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}