//
//  NewsTableViewCell.swift
//  UI_Practice
//
//  Created by Dmitrii Diadiushkin on 01.06.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsHeader: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var fotoNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}


