//
//  AllGroupsTableViewCell.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 10.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    var groupSignMark = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpView(signed: Bool){
        if signed {
            groupSignMark.textColor = .gray
            groupSignMark.translatesAutoresizingMaskIntoConstraints = false
            groupName.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(groupSignMark)
            let groupSignMarkConstraint = [
                groupSignMark.leadingAnchor.constraint(equalTo: groupAvatar.trailingAnchor, constant: 10),
                groupSignMark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
                groupSignMark.bottomAnchor.constraint(equalTo: groupAvatar.bottomAnchor, constant: 0)
            ]
            let groupNameConstraint = [
                groupName.leadingAnchor.constraint(equalTo: groupAvatar.trailingAnchor, constant: 10),
                groupName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
                groupName.topAnchor.constraint(equalTo: groupAvatar.topAnchor, constant: 0)
            ]
            NSLayoutConstraint.activate(groupSignMarkConstraint + groupNameConstraint)
        } else {
            groupName.translatesAutoresizingMaskIntoConstraints = false
            let groupNameConstraint = [
                groupName.leadingAnchor.constraint(equalTo: groupAvatar.trailingAnchor, constant: 10),
                groupName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
                groupName.centerYAnchor.constraint(equalTo: groupAvatar.centerYAnchor, constant: 0)
            ]
            NSLayoutConstraint.activate(groupNameConstraint)
        }
    }
}
