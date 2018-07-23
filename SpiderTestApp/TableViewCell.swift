//
//  TableViewCell.swift
//  SpiderTestApp
//
//  Created by Антон on 21.07.2018.
//  Copyright © 2018 Anton Trofimov. All rights reserved.
//

import UIKit
import ImgurSession

class TableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
