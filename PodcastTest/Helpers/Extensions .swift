//
//  Extensions .swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import Foundation
import UIKit

//MARK: - UIIMAGE
extension UIImage {
   static let LikeIcon = #imageLiteral(resourceName: "Vector")
    static let menueDotsIcon = #imageLiteral(resourceName: "Frame 40")
}


extension UIColor {
   static let Chimney = UIColor(named: "ChimneySweep")
}




// MARK: - NavgationBar
extension UINavigationController {
    func setupTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}
