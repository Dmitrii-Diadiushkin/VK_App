//
//  NetworkManager.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 16.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    private let baseURL = "https://api.vk.com"
    private let version = "5.92"
    
    func getFriendList(token: String){
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "order": "name",
            "fields": "name",
            "v": version
            
        ]
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseJSON{ response in
            guard let json = response.value else { return }
            
            print(json)
        }
        
    }
    
    func getPhotos(token: String){
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "access_token": token,
            "v": version
            
        ]
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseJSON{ response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    func getUserGroups(token: String){
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "extended": "1",
            "v": version
            
        ]
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseJSON{ response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    func getSearchedGroups(token: String, search: String){
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "access_token": token,
            "q": search,
            "v": version
            
        ]
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseJSON{ response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
}
