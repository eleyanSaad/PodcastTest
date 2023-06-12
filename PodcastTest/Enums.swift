//
//  Enums.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import Foundation
import UIKit
enum AppStoryboard: String {
    case main = "Main"
    case auth = "Auth"
    // Add more cases for other storyboards in your project
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T {
        guard let viewController = instance.instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Unable to instantiate view controller with identifier \(String(describing: type))")
        }
        return viewController
    }
}
