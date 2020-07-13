//
//  Friends.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 08.07.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit

struct friendsData: Equatable {
    var friendName: String
    var friendFoto: [friendFoto]
}

struct friendFoto:Equatable {
    var fotoName: UIImage
    var fotoLiked: Bool
    var fotoLikes: Int
}

var friends: [friendsData] = [friendsData(friendName: "Harley Quinn",friendFoto: [friendFoto(fotoName: UIImage(named: "HQF0")!, fotoLiked: false, fotoLikes: 1),friendFoto(fotoName: UIImage(named: "HQF1")!, fotoLiked: false, fotoLikes: 1),friendFoto(fotoName: UIImage(named: "HQF2")!, fotoLiked: false, fotoLikes: 1),friendFoto(fotoName: UIImage(named: "HQF3")!, fotoLiked: false, fotoLikes: 5)]),
friendsData(friendName: "Kenny McCormick", friendFoto: [friendFoto(fotoName: UIImage(named: "KMcKF0")!, fotoLiked: true, fotoLikes: 2),friendFoto(fotoName: UIImage(named: "KMcKF1")!, fotoLiked: true, fotoLikes: 2),friendFoto(fotoName: UIImage(named: "KMcKF2")!, fotoLiked: true, fotoLikes: 2),friendFoto(fotoName: UIImage(named: "KMcKF3")!, fotoLiked: true, fotoLikes: 4)]),
friendsData(friendName: "Lisa Simpson", friendFoto: [friendFoto(fotoName: UIImage(named: "LSF0")!, fotoLiked: false, fotoLikes: 3),friendFoto(fotoName: UIImage(named: "LSF1")!, fotoLiked: false, fotoLikes: 3),friendFoto(fotoName: UIImage(named: "LSF2")!, fotoLiked: false, fotoLikes: 3),friendFoto(fotoName: UIImage(named: "LSF3")!, fotoLiked: false, fotoLikes: 8)]),
friendsData(friendName: "Poison Ivy", friendFoto: [friendFoto(fotoName: UIImage(named: "PIF0")!, fotoLiked: true, fotoLikes: 4),friendFoto(fotoName: UIImage(named: "PIF1")!, fotoLiked: true, fotoLikes: 4),friendFoto(fotoName: UIImage(named: "PIF2")!, fotoLiked: true, fotoLikes: 4),friendFoto(fotoName: UIImage(named: "PIF3")!, fotoLiked: true, fotoLikes: 2)]),
friendsData(friendName: "Lumpy", friendFoto: [friendFoto(fotoName: UIImage(named: "LF0")!, fotoLiked: false, fotoLikes: 5),friendFoto(fotoName: UIImage(named: "LF1")!, fotoLiked: false, fotoLikes: 5),friendFoto(fotoName: UIImage(named: "LF2")!, fotoLiked: false, fotoLikes: 5),friendFoto(fotoName: UIImage(named: "LF3")!, fotoLiked: false, fotoLikes: 1)])]
