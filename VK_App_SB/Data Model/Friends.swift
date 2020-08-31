//
//  Friends.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 19.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//
//   let friends = try? newJSONDecoder().decode(Friends.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Friends
class Friends: Codable {
    let response: Response
}

// MARK: - Response
class Response: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
class Friend: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var isClosed: Bool = true
    @objc dynamic var canAccessClosed: Bool = true
    @objc dynamic var photo100: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var trackCode: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case photo100 = "photo_100"
        case online
        case trackCode = "track_code"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
