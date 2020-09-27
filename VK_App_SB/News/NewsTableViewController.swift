//
//  NewsTableViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 24.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib(nibName: "NewsPostTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        self.tableView.register(UINib(nibName: "NewsPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "newsPhotoCell")
        

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsPostTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "newsPhotoCell", for: indexPath) as! NewsPhotoTableViewCell

        // Configure the cell...
        return cell
    }

}
