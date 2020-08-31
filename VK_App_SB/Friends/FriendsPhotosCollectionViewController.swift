//
//  FriendsPhotosCollectionViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//


import UIKit
import RealmSwift
import SDWebImage

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var selectedUserID = String()
    let networkManager = NetworkManager.shared
    let realmManager = RealmManager.shared
    var userPhotos = [String]()
    
    private lazy var reloadControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Reload data...",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 10)])
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        collectionView.refreshControl = reloadControl
        loadData()
    }
    
    func loadData(completion: (() -> Void)? = nil) {
        networkManager.getPhotos(token: Session.shared.token, owner_id: selectedUserID) { [weak self] result in
            
            switch result {
            case let .success(photos):
                for photo in photos{
                    var photoURL = ""
                    for photoSize in photo.photoSizes{
                        if photoSize.photoSize == "x" {
                            photoURL = photoSize.photoURL
                        }
                    }
                    self?.userPhotos.append(photoURL)
                }
                self?.collectionView.reloadData()
                completion?()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        loadData { [weak self] in
            self?.collectionView.refreshControl?.endRefreshing()
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
        guard let url = URL(string: userPhotos[indexPath.row]) else { return cell}
        cell.friendPhoto.sd_setImage(with: url, completed: nil)
            
        return cell
    }
}
