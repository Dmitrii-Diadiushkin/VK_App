//
//  Photos.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 19.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

//   let photos = try? newJSONDecoder().decode(Photos.self, from: jsonData)

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [ItemPhoto]
}

// MARK: - Item
struct ItemPhoto: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let postID: Int?
    let sizes: [Size]
    let text: String
    let likes: Likes
    let reposts: Reposts

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case postID = "post_id"
        case sizes, text, likes, reposts
    }
    
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
