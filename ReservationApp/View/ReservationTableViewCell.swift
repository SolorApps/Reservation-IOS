//
//  ReservationTableViewCell.swift
//  ReservationApp
//
//  Created by Erick Manrique on 3/31/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
