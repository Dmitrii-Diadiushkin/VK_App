//
//  LikeControl.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 13.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    var likeImage = UIImageView()
    var likeCounter = UILabel()
    var indexLike: Int = 0
    var photoCounter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        likeImage.frame.size.height = self.frame.height
        likeImage.frame.size.width = likeImage.frame.height
        
        self.addSubview(likeImage)
        
        likeCounter.frame.size.height = self.frame.height
        self.addSubview(likeCounter)
        
        likeCounter.translatesAutoresizingMaskIntoConstraints = false
        likeImage.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint(item: likeCounter, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: likeCounter, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: likeImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 1).isActive = true
        NSLayoutConstraint(item: likeCounter, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: likeImage, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true

        likeCounter.font = likeCounter.font.withSize(10)
        
        if friends[indexLike].friendFoto[photoCounter].fotoLiked {
            likeImage.image = UIImage(systemName: "heart.fill")
            likeCounter.textColor = .red
        }else{
            likeImage.image = UIImage(systemName: "heart")
        }
        likeCounter.text = String(friends[indexLike].friendFoto[photoCounter].fotoLikes)
        
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        if friends[self.indexLike].friendFoto[self.photoCounter].fotoLiked {
            self.likeImage.image = UIImage(systemName: "heart")
            friends[self.indexLike].friendFoto[self.photoCounter].fotoLikes -= 1
            friends[self.indexLike].friendFoto[self.photoCounter].fotoLiked = false
            self.likeCounter.text = String(friends[self.indexLike].friendFoto[self.photoCounter].fotoLikes)
            likeCounter.textColor = .black
            
        }else{
            self.likeImage.image = UIImage(systemName: "heart.fill")
            friends[self.indexLike].friendFoto[self.photoCounter].fotoLikes += 1
            friends[self.indexLike].friendFoto[self.photoCounter].fotoLiked = true
            self.likeCounter.text = String(friends[self.indexLike].friendFoto[self.photoCounter].fotoLikes)
            likeCounter.textColor = .red
        }
        return false
    }
    
}
