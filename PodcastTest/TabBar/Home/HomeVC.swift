//
//  HomeVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import UIKit
import ParallaxHeader
import SDWebImage
import SkeletonView
import AVFAudio
import AVKit



class HomeVC: UIViewController{
    
    // MARK: - OUTLETS
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var headerLabel:UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var podCastMainBackGroundImageView: UIImageView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var podCastDescraptionLabel: UILabel!
    @IBOutlet weak var podCastTitleLabel: UILabel!
    @IBOutlet weak var botomView: UIView!
    @IBOutlet weak var tableHight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playListTabelView: ContentSizedTableView!
    @IBOutlet var TopheaderView: UIView!
    @IBOutlet weak var visualBlurView: UIVisualEffectView!{
        didSet{
            self.visualBlurView.alpha = 0
        }
    }
    
    // MARK: - VARAIBLES
    var audioPlayer: AVPlayer?
    var eposidesData: [EposideClass] = []
    var playListData: PlaylistData?
    var headBackView:UIView!
    var scrollOffset = 0
    let offset_B_LabelHeader:CGFloat = 190 // At this offset the Black label reaches the Header
    let distance_W_LabelHeader:CGFloat = 55.0 // The distance between the bottom of the Header and the top of the White Label
    private var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPlayListDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.audioPlayer?.pause()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHight?.constant = self.playListTabelView.intrinsicContentSize.height
    }
    
    // MARK: - API
    func getPlayListDetails(){
        self.playListTabelView.isSkeletonable = true
        self.playListTabelView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
        API.getPlayListDetails { playList, message, error in
            
            self.playListTabelView.stopSkeletonAnimation()
            self.stopSkeletonView()
            self.playListTabelView.hideSkeleton()
            if error == nil {
                self.playListData = playList
                
                for i in playList?.episodes ?? []{
                    let eposide = EposideClass(eposide: i,isPlaying: false )
                    self.eposidesData.append(eposide)
                }
                
                self.playListTabelView.reloadData()
                
                guard let playList = playList?.playlist else { return  }
                
                self.podCastTitleLabel.text = playList.name
                self.podCastDescraptionLabel.text =  playList.description
                
                self.podCastMainBackGroundImageView.sd_setImage(with: URL(string: playList.image ?? ""), placeholderImage: .menueDotsIcon)
                self.headerLabel.text = self.podCastTitleLabel.text
                self.episodeNumberLabel.text = "\(playList.episodeCount ?? 0) حلقة ,\(playList.episodeTotalDuration?.formattedTimeString ?? "")"
                
            }else{
                
                if message == "500" || message == "401"{
                    // this mean ,my access toke is expired , so need to use sotred refresh token ,to get new access token and recall the request , but in this api collection i didn't found endPoint for this.
                    
                    //                  self.getPlayListDetails()
                    
                    self.errorAlert(title: "تنبيه", body: "this mean ,my access toke is expired , so need to use sotred refresh token ,to get new access token and recall the request , but in this api collection i didn't found endPoint for this" )
                    
                    
                    self.showAlertWithAction(title: "تنبيه", message: "this mean ,my access toke is expired , so need to use sotred refresh token ,to get new access token and recall the request , but in this api collection i didn't found endPoint for this, so my current sloution to can fix this with out refresh token endpoit , is logout from the app and login again" , buttonText: "تسجيل خروج")
                    
                }else {
                    self.errorAlert(title: "تنبيه", body: message )
                }
            }
        }
    }
    
    // MARK: - FUNCATIONS
    func setupUI(){
        self.registerNibCells()
        self.loadSkeletonView()
        setupParallaxHeader()
        botomView.layer.cornerRadius = 10
        botomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.scrollView.delegate = self
        // Make the navigation bar transparent
        navigationController?.setupTransparentNavigationBar()
        headBackView = UIView(frame: headerView.bounds)
        headBackView.backgroundColor = .white
        headBackView?.alpha = 0.0
        headerView.insertSubview(headBackView, belowSubview: headerLabel)
        headerView.clipsToBounds = true
    }
    
    
    func loadSkeletonView(){
        self.podCastTitleLabel.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
        
        self.podCastDescraptionLabel.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
        
        self.podCastMainBackGroundImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func stopSkeletonView(){
        self.podCastTitleLabel.hideSkeleton()
        self.podCastDescraptionLabel.hideSkeleton()
        self.podCastMainBackGroundImageView.hideSkeleton()
    }
    
    private func setupParallaxHeader() {
        //height for header without navigation bar & tab bar
        //& first cell with horizontal slider
        let  headerHeight = 100
        
        let parallaxHeight: CGFloat = CGFloat(headerHeight)
        scrollView.parallaxHeader.view = TopheaderView
        scrollView.parallaxHeader.height = 400
        scrollView.parallaxHeader.minimumHeight = 40
        scrollView.parallaxHeader.mode = .fill
        scrollView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            
            if parallaxHeader.progress == 0 {
                self.likeButton.backgroundColor = .Chimney?.withAlphaComponent(1)
                self.menuButton.backgroundColor = .Chimney?.withAlphaComponent(1)
            }else{
                self.likeButton.backgroundColor = .Chimney?.withAlphaComponent(0.12)
                self.menuButton.backgroundColor = .Chimney?.withAlphaComponent(0.12)
            }
            
            let factor = (parallaxHeader.progress-1)*1/2 // to minimize the scaling factor
            let factor2 = (parallaxHeader.progress-1)*1/4 // to minimize the scaling factor
            self.visualBlurView.alpha =  (parallaxHeader.progress - 1)*2
            self.headerView.alpha = (parallaxHeader.progress - 0.5) * -2
        }
    }
    
    func registerNibCells(){
        let playListNibCell = UINib(nibName: "PlayListTableCellNib", bundle: nil)
        playListTabelView.register(playListNibCell, forCellReuseIdentifier: PlayListTableCell.cellID)
        playListTabelView.rowHeight = 110
    }
    
    func stopOthersItems(row: Int){
        for (index, object) in eposidesData.enumerated() {
            if index == row {
                object.isPlaying = true
            } else {
                object.isPlaying = false
            }
        }
    }
    
    
    //MARK: - Actions
    @IBAction func downLoadTapped(_ sender: Any) {
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
}

// MARK: - UITableView_DataSource
extension HomeVC: UITableViewDelegate,UITableViewDataSource, SkeletonTableViewDataSource,PlayListActionsProtocol {
    
    func playPodCastTapped(cell: PlayListTableCell) {
        guard let indexPath = playListTabelView.indexPath(for: cell) else {
            return
        }
        
        if let audioURL = self.eposidesData[indexPath.row].eposide?.audioLink{
            let playerItem = AVPlayerItem(url: URL(string: audioURL)!)
            audioPlayer = AVPlayer(playerItem: playerItem)
            
            if  self.eposidesData[indexPath.row].isPlaying == true {
                self.eposidesData[indexPath.row].isPlaying = false
                audioPlayer?.pause()
                playListTabelView.reloadRows(at: [indexPath], with: .automatic)
            }else{
                self.stopOthersItems(row: indexPath.row)
                audioPlayer?.play()
                playListTabelView.reloadData()
            }
        }
    }
    
    func dropListTapped(cell: PlayListTableCell) {
        print("")
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PlayListTableCell.cellID
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eposidesData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableCell.cellID) as? PlayListTableCell
        let obj = eposidesData[indexPath.row]
        cell?.setData(data: obj)
        cell?.delegate = self
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return cell!
    }
    
}

extension HomeVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y
        let height =  scrollView.contentOffset.y
        var headerTransform = CATransform3DIdentity
        
        offset = (offset * -1)
        self.scrollOffset = Int(offset)
        if offset > 0 {
            var t =   offset - offset_B_LabelHeader
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, t), 0)
            headerLabel.layer.transform = labelTransform
        }
        
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        let distance = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        
        guard abs(distance) > 140 else {return}
        if(distance > 0)
        {
            self.view.layoutIfNeeded()
            //
            print("Unhide")
            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction], animations: {
                //                self.lastContentH.constant = 105 // Your initial height of header view
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        else
        {
            print("down")
            
            self.view.layoutIfNeeded()
            print("Hide")
            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction], animations: {
                //                self.lastContentH.constant = 0
                
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
}
