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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        for index in friends {
            if !friendsIndex.contains(String(index.friendName.first!)){
                friendsIndex.append(String(index.friendName.first!))
            }
        }
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsIndex
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        
        cell.friendAvatarView.avatarImage.image = friends[indexPath.row].friendFoto[0].fotoName
        cell.friendName.text = friends[indexPath.row].friendName
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let friendPhotosView = segue.destination as! FriendsPhotosCollectionViewController
                friendPhotosView.selectedFriend = indexPath.row
                
            }
        }
    }

}
