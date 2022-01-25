//
//  FilterCell.swift
//  JnJ
//
//  Created by Admin on 21/01/22.
//

import UIKit


class FilterCell: UITableViewCell {
    

    @IBOutlet weak var lblFilterTitle: UILabel!
    @IBOutlet weak var lblSelectedFilter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }

}
