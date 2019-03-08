//
//  OnGoingListTableViewCell.swift
//  Learn Cab
//
//  Created by Exarcplus on 30/11/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit

class OnGoingListTableViewCell: UITableViewCell {

    @IBOutlet weak var eventlab : UILabel!
    @IBOutlet weak var descriptionlab : UILabel!
    @IBOutlet weak var timelab : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
