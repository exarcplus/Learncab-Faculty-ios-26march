//
//  BookigDateListTableViewCell.swift
//  Learn Cab
//
//  Created by Exarcplus on 16/02/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit

class BookigDateListTableViewCell: UITableViewCell {
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var timelabel : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
