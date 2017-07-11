//
//  CustomTableViewCell.swift
//  one
//
//  Created by iii-user on 2017/7/11.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
