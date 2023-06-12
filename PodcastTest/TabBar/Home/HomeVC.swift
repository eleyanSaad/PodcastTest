//
//  HomeVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var playListTabelView: UITableView!
    
    // MARK: - VARAIBLES
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibCells()
        // Make the navigation bar transparent
        navigationController?.setupTransparentNavigationBar()
//        setupNavgationsButton()
        // Do any additional setup after loading the view.
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
