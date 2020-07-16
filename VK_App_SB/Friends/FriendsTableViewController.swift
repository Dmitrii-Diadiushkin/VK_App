//
//  FriendsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var selecterRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell

        cell.friendAvatar.image = friends[indexPath.row].friendFoto[0].fotoName
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
