//
//  PublishedTableViewCell.swift
//  Learn Cab
//
//  Created by Exarcplus on 22/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit

class PublishedTableViewCell: UITableViewCell {
    @IBOutlet weak var eventlab : UILabel!
    @IBOutlet weak var descriptionlab : UILabel!
    @IBOutlet weak var reschdulebtn : UIButton!
    @IBOutlet weak var reschduleimg : UIImageView!
    @IBOutlet weak var approvebtn : UIButton!
    @IBOutlet weak var approveimg : UIImageView!
    @IBOutlet weak var playlistview : UIView!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
