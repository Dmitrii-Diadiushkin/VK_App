//
//  Groups.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 19.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

//   let groups = try? newJSONDecoder().decode(Groups.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Groups
class Groups: Codable {
    let response: ResponseGroup
}

// MARK: - Response
class ResponseGroup: Codable {
    let count: Int
    let items: [ItemGroup]
}

// MARK: - Item
class ItemGroup: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var isAdmin: Int = 0
    @objc dynamic var isMember: Int = 0
    @objc dynamic var isAdvertiser: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
