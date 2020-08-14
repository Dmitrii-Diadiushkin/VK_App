//
//  Session.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 13.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import Foundation

class Session {
    
    var token: String = ""
    var userId: Int = 0
    
    static let shared = Session()
    
    private init() {}
}
