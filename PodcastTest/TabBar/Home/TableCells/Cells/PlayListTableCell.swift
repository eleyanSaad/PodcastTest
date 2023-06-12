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
    
    func setData(data: EposideClass?){
        
        if data?.isPlaying == true {
            self.playPodcastButton.setImage(UIImage(named: "pause"), for: .normal)
        }else{
            self.playPodcastButton.setImage(UIImage(named: "Play"), for: .normal)
        }
        guard let obj = data?.eposide else {
            return
        }
        
        
        self.podCastImageView.sd_setImage(with: URL(string: obj.image ?? ""), placeholderImage: .menueDotsIcon)
        self.podCastTitleLabel.text = obj.name?.convertHTMLToString()
        self.podCastDescrpationLabel.text = obj.podcastName ?? ""
        
        self.podCastDateLabel.text = " \(obj.releaseDate?.convertToCustomDateFormat(format: "MMMM", lang: "ar") ?? "") \(obj.releaseDate?.convertToCustomDateFormat(format: "yyy", lang: "en") ?? ""),.\(obj.duration?.formattedTimeString ?? "")"
    }

    
    // MARK: - ACTIONS
    @IBAction func dropListTapped(_ sender: Any) {
    }
    
    @IBAction func playPodCastTapped(_ sender: Any) {
        self.delegate?.playPodCastTapped(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
