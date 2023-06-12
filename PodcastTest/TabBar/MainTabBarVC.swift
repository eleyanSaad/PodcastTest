//
//  MainTabBarVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import Foundation
import UIKit


class CustomTabBar: UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
    
    private func updateShadowPath() {
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
}
