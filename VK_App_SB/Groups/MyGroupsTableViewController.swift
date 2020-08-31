//
//  MyGroupsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 10.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class MyGroupsTableViewController: UITableViewController {

    let networkManager = NetworkManager.shared
    let realmManager = RealmManager.shared
    
    private var myGroups: Results<ItemGroup>? {
        let myGroups: Results<ItemGroup>? = realmManager?.getObjects()
        return myGroups?.sorted(byKeyPath: "name", ascending: true)
    }
    
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
        self.tableView.tableFooterView = UIView()
        
        tableView.refreshControl = reloadControl
        
        loadData()

    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        try? realmManager?.deleteAll()
        loadData { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    private func loadData(completion: (() -> Void)? = nil){
        networkManager.getUserGroups(token: Session.shared.token) { [weak self] result in
            switch result {
            case let .success(myGroups):
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: myGroups)
                    self?.tableView.reloadData()
                    completion?()
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupsTableViewCell

        // Configure the cell...
        
        cell.groupName.text = myGroups?[indexPath.row].name
        
        guard let url = URL(string: myGroups?[indexPath.row].photo100 ?? "") else { return cell }
        cell.groupAvatar.sd_setImage(with: url)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            for index in 0..<allGroups.count{
//                if allGroups[index].groupName == myGroups[indexPath.row].groupName {
//                    allGroups[index].groupSigned = false
//                }
//            }
//            myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsTableViewController else {return}
            
//            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
//                let group = allGroups[indexPath.row]
//                if !myGroups.contains(group) {
//                    allGroups[indexPath.row].groupSigned = true
//                    myGroups.append(group)
//                    tableView.reloadData()
//                }
//            }
        }
    }

}
