//
//  Photos.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 19.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

//   let photos = try? newJSONDecoder().decode(Photos.self, from: jsonData)

import Foundation
import RealmSwift

class Photos: Decodable {
    let response: ResponsePhoto
}

class ResponsePhoto: Decodable {
    let count: Int
    let items: [PhotoItem]
}

class PhotoItem: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    var photoSizes: [String : String] = [:]
    @objc dynamic var likes: Int = 0
    @objc dynamic var liked: Int = 0
    
    enum CodingKeys: String, CodingKey{
        case id
        case ownerID = "owner_id"
        case sizes
        case likes
    }
    enum PhotoSizesCodingKeys: String, CodingKey{
        case height, url, type, width
    }
    enum LikesCodingKeys: String, CodingKey{
        case userLikes = "user_likes"
        case count
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.ownerID = try value.decode(Int.self, forKey: .ownerID)
        
        var photoSizeData = try value.nestedUnkeyedContainer(forKey: .sizes)
        
        while !photoSizeData.isAtEnd {
            let photo = try photoSizeData.nestedContainer(keyedBy: PhotoSizesCodingKeys.self)
            let photoType = try photo.decode(String.self, forKey: .type)
            let photoUrl = try photo.decode(String.self, forKey: .url)
            
            photoSizes[photoType] = photoUrl
        }
        
        let likesData = try value.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likes)
        liked = try likesData.decode(Int.self, forKey: .userLikes)
        likes = try likesData.decode(Int.self, forKey: .count)
    }
    override class func primaryKey() -> String? {
        "id"
    }
}
