//
//  Groups.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 10.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import Foundation
import UIKit

struct groupData: Equatable {
    var groupName: String
    var groupAvatar: UIImage
    var groupSigned: Bool
}

var allGroups: [groupData] = [groupData(groupName: "Happy Tree Friends", groupAvatar: UIImage(named: "htf")!, groupSigned: false),
groupData(groupName: "Simpsons", groupAvatar: UIImage(named: "simpsons")!, groupSigned: false),
groupData(groupName: "South Park", groupAvatar: UIImage(named: "sp")!, groupSigned: false),
groupData(groupName: "Rick and Morty", groupAvatar: UIImage(named: "RnM")!, groupSigned: false),
groupData(groupName: "Harley Quinn", groupAvatar: UIImage(named: "HQ")!, groupSigned: true)]

var myGroups: [groupData] = [groupData(groupName: "Harley Quinn", groupAvatar: UIImage(named: "HQ")!, groupSigned: true)]
