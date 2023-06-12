//
//  MainTabBarVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import Foundation
import UIKit


class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.shadowOffset = CGSize(width: -2, height: -4)
        tabBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.18).cgColor
        tabBar.layer.shadowOpacity = 4
        selectedIndex = 2

    }
    
    
}
