//
//  FriendsPhotosCollectionViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//


import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var selectedUserID = String()
    let networkManager = NetworkManager.shared
    var userPhotos = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        networkManager.getPhotos(token: Session.shared.token, owner_id: selectedUserID) { [weak self] result in
            
            switch result {
            case let .success(photos):
                for photo in photos{
                    for size in photo.sizes{
                        if size.type == "x"{
                            self?.userPhotos.append(size.url)
                        }
                    }
                }
                self?.collectionView.reloadData()
                print(self!.userPhotos.count)
            case let .failure(error):
                print(error)
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotosCell", for: indexPath) as! FriendPhotosCollectionViewCell
    
        // Configure the cell
        guard let url = URL(string: userPhotos[indexPath.row]),
        let data = try? Data(contentsOf: url) else { return cell}
        cell.friendPhoto.image = UIImage(data: data)
//        cell.friendPhoto.image = filteredFriends[selectedFriend].friendFoto[indexPath.row].fotoName
//        cell.photoCounter = indexPath.row
//        cell.friendIndex = selectedFriend
//        cell.setUpLikeControl()
    
        return cell
    }
}
