//
//  CompletedTableViewCell.swift
//  Learn Cab
//
//  Created by Exarcplus on 30/11/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit

class CompletedTableViewCell: UITableViewCell {
    @IBOutlet weak var eventlab : UILabel!
    @IBOutlet weak var descriptionlab : UILabel!
    @IBOutlet weak var reschdulebtn : UIButton!
    @IBOutlet weak var reschduleimg : UIImageView!
    @IBOutlet weak var approvebtn : UIButton!
    @IBOutlet weak var approveimg : UIImageView!
    @IBOutlet weak var playlistview : UIView!
    @IBOutlet weak var approvelab : UILabel!
    @IBOutlet weak var reschdulelab : UILabel!
    
     @IBOutlet weak var countlab : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
