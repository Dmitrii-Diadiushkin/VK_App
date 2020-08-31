//
//  NetworkManager.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 16.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

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
    private let userID = Session.shared.userId
    let realmManager = RealmManager.shared
    
    func getFriendList(token: String, completion: ((Swift.Result<[Friend], Error>) -> Void)? = nil) {
        
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "order": "name",
            "fields": "name, photo_100",
            "v": version
        ]
        
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseData{ response in
            guard let json = response.value else { return }
            do {
                let friends = try JSONDecoder().decode(Friends.self, from: json)
                completion?(.success(friends.response.items))
            } catch {
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        }
    }
    
    func getPhotos(token: String, owner_id: String, completion: ((Swift.Result<[PhotoItem], Error>) -> Void)? = nil) {
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "access_token": token,
            "owner_id": owner_id,
            "extended": "1",
            "v": version
            
        ]
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseData{ response in
            guard let json = response.value else { return }
            do {
                let photos = try JSONDecoder().decode(Photos.self, from: json)
                self.realmManager?.addObject(photos.response.items)
                completion?(.success(photos.response.items))
            } catch {
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        }
    }
    
    func getUserGroups(token: String, completion: ((Swift.Result<[ItemGroup], Error>) -> Void)? = nil){
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "extended": "1",
            "v": version
            
        ]
        NetworkManager.session.request(baseURL + path, method: .get, parameters: parameters).responseData { response in
            guard let json = response.value else { return }
            do {
                let groups = try JSONDecoder().decode(Groups.self, from: json)
                self.realmManager?.addObject(groups.response.items)
                completion?(.success(groups.response.items))
            } catch {
                completion?(.failure(error))
            }
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
