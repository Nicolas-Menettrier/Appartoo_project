//
//  BarTableViewCell.swift
//  Appartoo_bar
//
//  Created by Nicolas Menettrier on 30/05/2016.
//  Copyright © 2016 Nicolas Menettrier. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell {

    @IBOutlet weak var bar_photo: UIImageView!
    @IBOutlet weak var bar_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
