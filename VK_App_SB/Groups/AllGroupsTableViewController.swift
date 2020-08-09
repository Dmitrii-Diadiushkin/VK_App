//
//  AllGroupsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 10.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! AllGroupsTableViewCell

        // Configure the cell...
        cell.groupAvatar.image = allGroups[indexPath.row].groupAvatar
        cell.groupName.text = allGroups[indexPath.row].groupName
        
        cell.setUpView(signed: allGroups[indexPath.row].groupSigned)
        
        if allGroups[indexPath.row].groupSigned {
            cell.groupSignMark.text = "Signed"
        }

        return cell
    }

}
