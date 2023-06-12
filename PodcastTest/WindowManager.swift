//
//  WindowManager.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import Foundation
import UIKit


enum StoryBoards: String {
case main = "Main"
case auth = "Auth"
}

class WindowManager {
    
    static let shared = WindowManager()
    
    private var window: UIWindow?
    
    private init() {
        // Private initializer to enforce singleton pattern
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        // Set the initial root view controller
        let initialViewController = UIViewController() // Replace with your desired initial view controller
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }

    
    func transitionToViewController(withIdentifier identifier: String, storyBoard: StoryBoards?) {
        
        guard let storyBoard = storyBoard?.rawValue else { return }
        
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}
