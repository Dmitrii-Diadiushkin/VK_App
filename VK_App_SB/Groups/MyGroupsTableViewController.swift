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
    
    private var myGroupsNotificationToken: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGroupsNotificationToken = myGroups?.observe { [weak self] change in
            switch change {
            case .initial:
                print("Initialized")
            case let .update(results, deletions: deletions, insertions: insertions, modifications: modifications):
                print("""
                    New count: \(results.count)
                    Deletions: \(deletions)
                    Insertion: \(insertions)
                    Modifications: \(modifications)
                """)
                self?.tableView.reloadData()
            case let .error(error):
                print("\(error.localizedDescription)")
            }
            
        }
        
        self.tableView.tableFooterView = UIView()
        
        tableView.refreshControl = reloadControl
        
        loadData()

    }
    
    deinit {
        myGroupsNotificationToken?.invalidate()
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
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
}
