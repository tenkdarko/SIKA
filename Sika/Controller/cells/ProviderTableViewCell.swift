//
//  ProviderTableViewCell.swift
//  ProviderTableViewCell
//
//  Created by K on 8/18/21.
//  Copyright © 2021 KWAME DARKO. All rights reserved.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowDecorate()
    }
    
    @IBOutlet weak var viewProvider: UIView!
    

    @IBOutlet weak var providerImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func shadowDecorate() {
        // cell rounded section
         self.layer.cornerRadius = 15.0
         self.layer.borderWidth = 5.0
         self.layer.borderColor = UIColor.clear.cgColor
         self.layer.masksToBounds = true
         
         // cell shadow section
         self.contentView.layer.cornerRadius = 15.0
         self.contentView.layer.borderWidth = 5.0
         self.contentView.layer.borderColor = UIColor.clear.cgColor
         self.contentView.layer.masksToBounds = true
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
         self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.5
         self.layer.cornerRadius = 15.0
         self.layer.masksToBounds = false
         self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

}
