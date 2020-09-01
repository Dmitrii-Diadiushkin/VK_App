//
//  PhotoSizes.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 28.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoSizes: Object, Decodable {
    
    @objc dynamic var photoSize: String = ""
    @objc dynamic var photoURL: String = ""
}
