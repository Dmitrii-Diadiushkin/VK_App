//
//  MyGroupsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 10.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {

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
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupsTableViewCell

        // Configure the cell...
        
        cell.groupAvatar.image = myGroups[indexPath.row].groupAvatar
        cell.groupName.text = myGroups[indexPath.row].groupName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            for index in 0..<allGroups.count{
                if allGroups[index].groupName == myGroups[indexPath.row].groupName {
                    allGroups[index].groupSigned = false
                }
            }
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsTableViewController else {return}
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let group = allGroups[indexPath.row]
                if !myGroups.contains(group) {
                    allGroups[indexPath.row].groupSigned = true
                    myGroups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }

}
