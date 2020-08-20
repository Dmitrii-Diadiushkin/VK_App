//
//  Friends.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 19.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//
//   let friends = try? newJSONDecoder().decode(Friends.self, from: jsonData)

import Foundation

// MARK: - Friends
struct Friends: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool
    let photo100: String
    let online: Int
    let trackCode: String

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
}

var friendsVK = [Item]()
var friendsToShow = [Item]()
