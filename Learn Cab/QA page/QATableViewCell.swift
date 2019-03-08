//
//  QATableViewCell.swift
//  Learn Cab
//
//  Created by Vignesh Waran on 22/02/19.
//  Copyright © 2019 Exarcplus. All rights reserved.
//

import UIKit

class QATableViewCell: UITableViewCell {

    
    @IBOutlet weak var std_id : UILabel!
    @IBOutlet weak var std_image : UIImageView!
    @IBOutlet weak var std_name : UILabel!
    @IBOutlet weak var timelbl : UILabel!
    @IBOutlet weak var QAlbl : UILabel!
    
    @IBOutlet weak var replybtn : UIButton!
    @IBOutlet weak var blockbtn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
