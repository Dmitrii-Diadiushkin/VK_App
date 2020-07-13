//
//  FriendPhotosCollectionViewCell.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class FriendPhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var photoLikes: LikeControl!
    
    var friendIndex: Int = 0
    var photoCounter: Int = 0
    
    func setUpLikeControl() {
        photoLikes.indexLike = friendIndex
        photoLikes.photoCounter = photoCounter
        photoLikes.setUpView()
    }
}
