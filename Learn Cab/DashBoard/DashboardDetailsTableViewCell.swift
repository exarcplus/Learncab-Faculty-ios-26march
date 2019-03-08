//
//  DashboardDetailsTableViewCell.swift
//  Learn Cab
//
//  Created by Vignesh Waran on 12/02/19.
//  Copyright © 2019 Exarcplus. All rights reserved.
//

import UIKit

class DashboardDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var stdid:UILabel!
    @IBOutlet weak var credit:UILabel!
     @IBOutlet weak var course_name:UILabel!
     @IBOutlet weak var chapter:UILabel!
     @IBOutlet weak var discount:UILabel!
     @IBOutlet weak var datetime:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
