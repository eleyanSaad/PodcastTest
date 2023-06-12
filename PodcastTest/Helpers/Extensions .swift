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
    
    class func colorForNavBar(color: UIColor) -> UIImage {
        //let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)

        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 1.0, height: 1.0))

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()


         return image!
        } 
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
