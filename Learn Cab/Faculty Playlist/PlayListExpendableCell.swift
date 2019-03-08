//
//  PlayListExpendableCell.swift
//  Learn Cab
//
//  Created by Exarcplus on 20/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit

class PlayListExpendableCell: UITableViewCell {
    @IBOutlet var playlistname: UILabel!
    @IBOutlet var chptname: UILabel!
    @IBOutlet var bannerimg: UIImageView!
    @IBOutlet var webview: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
