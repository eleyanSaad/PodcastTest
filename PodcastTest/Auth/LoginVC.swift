//
//  LoginVC.swift
//  PodcastTest
//
//  Created by eleyan saad on 12/06/2023.
//

import UIKit

class LoginVC: UIViewController {

    
    // MARK: - OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        login()
    }
    
    // MARK: - API
    func login(){
        if emailTextField.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء ادخال البريد الالكتروني")
        }
        
        if passwordTextField.text == "" {
            self.errorAlert(title: "تنبيه", body: "الرجاء ادخال كلمة المرور")
        }
        
        if emailTextField.text?.isValidEmail == false {
            self.errorAlert(title: "تنبيه", body: "صيغة البريد الالكتروني غير صحيحة")
        }
        
        ActivityIndicatorManager.start()
        API.LoginAuth(email:  emailTextField.text!, password: passwordTextField.text!) { userData, message, error in
            
            ActivityIndicatorManager.stop()
            if error == nil {
                AppData.isLogin = true
                WindowManager.shared.transitionToViewController(withIdentifier: "MainTabBar", storyBoard: .main)
            }else{
                self.errorAlert(title: "تنبيه", body: message ?? "")
            }
        }
    }

 

}
