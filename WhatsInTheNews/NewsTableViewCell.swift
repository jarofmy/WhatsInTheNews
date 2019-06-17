//
//  NewsTableViewCell.swift
//  WhatsInTheNews
//
//  Created by Jeremy Van on 2/16/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {


    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsRecentLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
