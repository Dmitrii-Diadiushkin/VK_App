//
//  NewsTableViewCell.swift
//  UI_Practice
//
//  Created by Dmitrii Diadiushkin on 01.06.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class NewsPostTableViewCell: UITableViewCell {

    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var authorAvatar: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var commentsCounter: UILabel!
    @IBOutlet weak var repostCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}


