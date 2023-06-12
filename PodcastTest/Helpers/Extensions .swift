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

extension UIView {
    func roundTopCorners(radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}


// MARK: - NavgationBar
extension UINavigationController {
    func setupTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}


// MARK: - String
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


extension String {
    
    func convertToCustomDateFormat(format: String,lang: String) -> String? {
            let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: lang)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let date = dateFormatter.date(from: self) {
                dateFormatter.dateFormat = format
                return dateFormatter.string(from: date)
            }
            return nil
        }
    

    var isValidEmail: Bool {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func convertHTMLToString() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        }
        
        return nil
    }
}


// MARK: - UIViewController
extension UIViewController {
    func errorAlert(title : String , body : String){
        let alert = UIAlertController.init(title:title, message: body , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction.init(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithAction(title: String, message: String, buttonText: String, completion: (() -> Void)? = nil) {
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
         let action = UIAlertAction(title: buttonText, style: .default) { (_) in
             completion?()
         }
         
         alertController.addAction(action)
         
         present(alertController, animated: true, completion: nil)
     }
}


extension Int {
    var formattedTimeString: String {
        switch self {
        case ..<60:
            return "\(self) ثواني"
        case 60..<3600:
            let minutes = self / 60
            return "\(minutes) دقائق"
        default:
            let hours = self / 3600
            return "\(hours) ساعات"
        }
    }
}

////TableHighAutoSize
import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
