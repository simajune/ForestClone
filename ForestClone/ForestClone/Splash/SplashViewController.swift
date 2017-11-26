//
//  ViewController.swift
//  ForestClone

import UIKit
import SwiftKeychainWrapper
import Firebase

class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoIMG: UIImageView!
    let segueSplashToLogin = "segueSplashToLogin"
    let segueSplashToMain = "segueSplashToMain"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoIMG.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 2.0, animations: {
                self.logoIMG.alpha = 1.0
            }, completion: { [weak self] _ in
                guard let `self` = self else{ return }
                if let keyData = KeychainWrapper.standard.data(forKey: userAccount), let account = try? JSONDecoder().decode(Account.self, from: keyData){
                    Auth.auth().signIn(withEmail: account.email, password: account.pwd, completion: {[weak self] (user, error) in
                        guard let `self` = self else { return }
                        if error == nil, user != nil{
                            self.performSegue(withIdentifier: self.segueSplashToMain, sender: nil)
                        }else{
                            KeychainWrapper.standard.removeObject(forKey: userAccount)
                            self.performSegue(withIdentifier: self.segueSplashToLogin, sender: nil)
                        }
                    })
                }else{
                    self.performSegue(withIdentifier: self.segueSplashToLogin, sender: nil)
                }
            })
        }
    }
    
}




