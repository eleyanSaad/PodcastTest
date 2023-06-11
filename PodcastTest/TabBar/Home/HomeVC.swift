//
//  HomeVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - OUTLETS
    
    // MARK: - VARAIBLES
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the navigation bar transparent
        navigationController?.setupTransparentNavigationBar()
//        setupNavgationsButton()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - FUNCATIONS
    func setupNavgationsButton(){
        // Create the first custom button
        let likeButton = UIButton(type: .custom)
        likeButton.frame.size = CGSize(width: 39, height: 39)
        likeButton.backgroundColor = .Chimney?.withAlphaComponent(0.12)
        likeButton.layer.borderColor = UIColor.white.cgColor
        likeButton.layer.cornerRadius = 20
        
        likeButton.setImage(.LikeIcon, for: .normal) // Replace "likeButton_image" with the name of your first button image
//        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

        // Create the second custom button
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(.menueDotsIcon, for: .normal) // Replace "menuButton_image" with the name of your second button image
//        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)

        // Create a container view to hold the buttons
        let buttonsContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        buttonsContainerView.addSubview(likeButton)
        buttonsContainerView.addSubview(menuButton)

        // Set the layout constraints for the buttons
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
            likeButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor),
            menuButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15),
            menuButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor)
        ])


        // Create bar button items from the buttons container view
        let buttonsContainerItem = UIBarButtonItem(customView: buttonsContainerView)

        // Set the left navigation bar button items
        navigationItem.leftBarButtonItems = [buttonsContainerItem]
    }

    
    // MARK: - ACTIONS
    @objc func nationButtonTapped() {

        let alert = UIAlertController(title: "Nation Button", message: "Button tapped!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
