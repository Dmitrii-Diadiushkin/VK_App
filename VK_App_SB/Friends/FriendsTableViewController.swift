//
//  FriendsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friendsIndex = [String]()
    let networkManager = NetworkManager.shared
    
    @IBOutlet weak var searchFriendBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsIndex = [""]

        networkManager.getFriendList(token: Session.shared.token) { result in
            
            switch result {
            case let .success(friends):
                friendsVK = friends
                friendsToShow = friendsVK
                self.prepareSectionIndexes()
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
        
        searchFriendBar.delegate = self
        
        self.tableView.tableFooterView = UIView()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        if friendsIndex.count > 0 {
            return friendsIndex.count
        } else {
            return 1
        }
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsIndex
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsIndex[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var friendRow = [Item]()
        for friend in friendsToShow {
            if friendsIndex[section].contains(friend.firstName.first!) {
                friendRow.append(friend)
            }
        }
        return friendRow.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell

        var friendRow = [Item]()
        for friend in friendsToShow {
            if friendsIndex[indexPath.section].contains(friend.firstName.first!) {
                friendRow.append(friend)
            }
        }
        
        cell.friendName.text = friendRow[indexPath.row].firstName + " " + friendRow[indexPath.row].lastName
        guard let url = URL(string: friendRow[indexPath.row].photo100),
        let data = try? Data(contentsOf: url) else { return cell}
        
        
        cell.friendAvatarView.avatarImage.image = UIImage(data: data)
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let friendPhotosView = segue.destination as! FriendsPhotosCollectionViewController
                //Вычисляем сквозную нумерацию строки
                var indexRowCounter = 0
                for index in 0..<indexPath.section{
                    indexRowCounter += self.tableView.numberOfRows(inSection: index)
                }
                indexRowCounter += indexPath.row
                let selectedUserID = String(friendsToShow[indexRowCounter].id)
                friendPhotosView.selectedUserID = selectedUserID
            }
        }
    }
    
    func prepareSectionIndexes(){
        for index in friendsVK {
            if !friendsIndex.contains(String(index.firstName.first!)){
                friendsIndex.append(String(index.firstName.first!))
            }
        }
        
        friendsToShow.sort {
            $0.firstName < $1.firstName
        }
    }
}

extension FriendsTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        friendsToShow = searchText.isEmpty ? friendsVK : friendsVK.filter { (item: Item) -> Bool in
            return item.firstName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        friendsIndex = [String]()
        for index in friendsToShow {
            if !friendsIndex.contains(String(index.firstName.first!)){
                friendsIndex.append(String(index.firstName.first!))
            }
        }
        
        friendsToShow.sort {
            $0.firstName < $1.firstName
        }
        
        friendsIndex.sort()
        self.tableView.reloadData()
    }
}
