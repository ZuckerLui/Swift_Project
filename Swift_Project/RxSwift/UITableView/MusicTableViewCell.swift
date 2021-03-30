//
//  MusicTableViewCell.swift
//  Swift_Project
//
//  Created by jimi01 on 2021/3/25.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var songName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
