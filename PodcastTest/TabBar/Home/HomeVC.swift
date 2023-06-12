//
//  HomeVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import UIKit
import ParallaxHeader

class HomeVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playListTabelView: UITableView!
    @IBOutlet var TopheaderView: UIView!
    @IBOutlet weak var visualBlurView: UIVisualEffectView!{
        didSet{
            self.visualBlurView.alpha = 0
        }
    }
    // MARK: - VARAIBLES
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibCells()
        // Make the navigation bar transparent
        navigationController?.setupTransparentNavigationBar()
    }
    
    
    
    private func setupParallaxHeader() {
        //height for header without navigation bar & tab bar
        //& first cell with horizontal slider
        let  headerHeight = sliderHigh.constant
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let parallaxHeight: CGFloat = headerHeight
        scrollView.parallaxHeader.view = TopheaderView
        scrollView.parallaxHeader.height = parallaxHeight
        scrollView.parallaxHeader.minimumHeight = 150
        scrollView.parallaxHeader.mode = .fill
        scrollView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            
            if parallaxHeader.progress == 0 {
//                self.tabView.layer.cornerRadius = 0

            }else{
//                self.tabView.layer.cornerRadius = 25

            }
            
            let factor = (parallaxHeader.progress-1)*1/2 // to minimize the scaling factor
            let factor2 = (parallaxHeader.progress-1)*1/4 // to minimize the scaling factor
            self.visualBlurView.alpha =  (parallaxHeader.progress - 1)*2
            self.qosoorLogoImageView.alpha =  (parallaxHeader.progress - 1)*3
            self.header.alpha = (parallaxHeader.progress - 0.5) * -2
//            self.backLView.alpha =   (parallaxHeader.progress - 0.5) * 2
        }
    }
    // MARK: - FUNCATIONS
    func registerNibCells(){
        let playListNibCell = UINib(nibName: "PlayListTableCellNib", bundle: nil)
        playListTabelView.register(playListNibCell, forCellReuseIdentifier: PlayListTableCell.cellID)
        playListTabelView.rowHeight = 106
    }
    
    
    
    
}

// MARK: - UITableView_DataSource
extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableCell.cellID) as? PlayListTableCell
        return cell!
    }
    
}
