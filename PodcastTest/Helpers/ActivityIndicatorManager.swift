//
//  ActivityIndicatorManager.swift
//  kindergarten
//
//  Created by Amar Amassi  on 4/17/18.
//  Copyright © 2018 Amar Amassi . All rights reserved.
//

import Foundation
import RappleProgressHUD
class ActivityIndicatorManager: NSObject {
    public class func start(_ title: String = "") {
        let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.circle, tintColor: .blue, screenBG: .clear, progressBG: .clear, progressBarBG: .orange, progreeBarFill: .red, thickness: 4)

        RappleActivityIndicatorView.startAnimating(attributes: attributes)


    }

    public class func stop() {
        RappleActivityIndicatorView.stopAnimation()
//        SVProgressHUD.dismiss()

    }
    
    public class func showProgress(progress :  Float) {
        RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)
        #warning("Show Progress!")
    
    }

  
    
    public class func showAlertLog(view:UIViewController,type:String,isShow:Bool){
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DisconectAlertVC")
        
        vc.modalTransitionStyle   = .crossDissolve;
        vc.modalPresentationStyle = .overCurrentContext
        
        view.tabBarController?.present(vc, animated: true, completion: nil)
        
    }
        
}
