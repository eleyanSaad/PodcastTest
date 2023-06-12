//
//  PlayListTableCell.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import UIKit

// MARK: - Protocol

protocol PlayListActionsProtocol {
    func playPodCastTapped(cell: PlayListTableCell)
    func dropListTapped(cell: PlayListTableCell)
}

class PlayListTableCell: UITableViewCell {
// MARK: - OUTLETS
    @IBOutlet weak var playPodcastButton: UIButton!
    @IBOutlet weak var podCastDateLabel: UILabel!
    @IBOutlet weak var podCastDescrpationLabel: UILabel!
    @IBOutlet weak var podCastTitleLabel: UILabel!
    @IBOutlet weak var podCastImageView: UIImageView!
    
    // MARK: - VARIABLES
    
    static var cellID = "playListCellID"
    var delegate:PlayListActionsProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: - ACTIONS
    @IBAction func dropListTapped(_ sender: Any) {
    }
    
    @IBAction func playPodCastTapped(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
