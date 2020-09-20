//
//  NewsPhotoTableViewCell.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 20.09.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class NewsPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var commentsCounter: UILabel!
    @IBOutlet weak var repostCounter: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
