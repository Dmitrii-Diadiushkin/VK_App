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
    
    @IBOutlet weak var searchFriendBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        searchFriendBar.delegate = self
        
        filteredFriends = friends
        
        for index in friends {
            if !friendsIndex.contains(String(index.friendName.first!)){
                friendsIndex.append(String(index.friendName.first!))
            }
        }
        
        filteredFriends.sort {
            $0.friendName < $1.friendName
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsIndex.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsIndex
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsIndex[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var friendRow = [friendsData]()
        for friend in filteredFriends {
            if friendsIndex[section].contains(friend.friendName.first!) {
                friendRow.append(friend)
            }
        }
        return friendRow.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell

        var friendRow = [friendsData]()
        for friend in filteredFriends {
            if friendsIndex[indexPath.section].contains(friend.friendName.first!) {
                friendRow.append(friend)
            }
        }
        
        cell.friendAvatarView.avatarImage.image = friendRow[indexPath.row].friendFoto[0].fotoName
        cell.friendName.text = friendRow[indexPath.row].friendName
    
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
                
                friendPhotosView.selectedFriend = indexRowCounter
                
            }
        }
    }
}

extension FriendsTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredFriends = searchText.isEmpty ? friends : friends.filter { (item: friendsData) -> Bool in
            return item.friendName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        friendsIndex = [String]()
        
        for index in filteredFriends {
            if !friendsIndex.contains(String(index.friendName.first!)){
                friendsIndex.append(String(index.friendName.first!))
            }
        }
        
        filteredFriends.sort {
            $0.friendName < $1.friendName
        }
        
        friendsIndex.sort()
        self.tableView.reloadData()
    }
}
