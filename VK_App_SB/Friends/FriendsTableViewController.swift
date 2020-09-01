//
//  FriendsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class FriendsTableViewController: UITableViewController {
    
    let networkManager = NetworkManager.shared
    let realmManager = RealmManager.shared
    
    @IBOutlet weak var searchFriendBar: UISearchBar!
    
    var friendsIndex = [String]()
    
    private var friendsVK: Results<Friend>? {
        let friends: Results<Friend>? = realmManager?.getObjects()
        return friends?.sorted(byKeyPath: "firstName", ascending: true)
    }
    
    var friendsToShow: Results<Friend>? {
        guard !searchFriendBar.text!.isEmpty else {return friendsVK}
        return friendsVK?.filter(NSPredicate(format: "firstName CONTAINS[cd] %@", searchFriendBar.text!))
    }
    
    private lazy var reloadControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Reload data...",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 10)])
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private var friendsToShowNotificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        friendsToShowNotificationToken = friendsToShow?.observe { [weak self] change in
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
                    print(error.localizedDescription)
            }
            
        }
        
        searchFriendBar.delegate = self
        
        tableView.refreshControl = reloadControl
        
        self.tableView.tableFooterView = UIView()
    }
    
    deinit {
        friendsToShowNotificationToken?.invalidate()
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        loadData { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    private func loadData(completion: (() -> Void)? = nil) {
        networkManager.getFriendList(token: Session.shared.token) { [weak self] result in

            switch result {
            case let .success(friends):
                
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: friends)
                    completion?()
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        friendsIndex = [String]()
        for index in friendsToShow! {
            if !friendsIndex.contains(String(index.firstName.first!)){
                friendsIndex.append(String(index.firstName.first!))
            }
        }
        return friendsIndex.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsIndex
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsIndex[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var friendRow = [Friend]()
        for friend in friendsToShow! {
            if friendsIndex[section].contains(friend.firstName.first!) {
                friendRow.append(friend)
            }
        }
        return friendRow.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell

        var friendRow = [Friend]()
        for friend in friendsToShow! {
            if friendsIndex[indexPath.section].contains(friend.firstName.first!) {
                friendRow.append(friend)
            }
        }
        
        cell.friendName.text = friendRow[indexPath.row].firstName + " " + friendRow[indexPath.row].lastName
        guard let url = URL(string: friendRow[indexPath.row].photo100) else { return cell }
        
        cell.friendAvatarView.avatarImage.sd_setImage(with: url, completed: nil)
    
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
                let selectedUserID = String(friendsToShow![indexRowCounter].id)
                friendPhotosView.selectedUserID = selectedUserID
            }
        }
    }
}

extension FriendsTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.tableView.reloadData()
    }
}
