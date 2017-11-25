
import UIKit
import Firebase
import SwiftKeychainWrapper

let userAccount = "account"
class LoginViewController: UIViewController {
    // MARK: 프로퍼티
    lazy var reference: DatabaseReference = Database.database().reference()
    let segueloginToSignUp = "segueLoginToSignUp"
    let segueLoginToMain = "segueLoginToMain"
    
    // MARK: IBOulet
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    
    // MARK: IBAction
    // 회원가입 버튼
    @IBAction func signUpButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: segueloginToSignUp , sender: nil)
    }
    
    // 로그인 버튼
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTF.text, !email.isEmpty else { return }
        guard let pwd = pwdTF.text, !pwd.isEmpty else { return }
        Auth.auth().signIn(withEmail: email, password: pwd) { [weak self] (user, error) in
            guard let `self` = self else { return }
            if error == nil, user != nil {
                do{
                    let account = Account(email: email, pwd: pwd)
                    let data = try JSONEncoder().encode(account)
                    KeychainWrapper.standard.set(data, forKey: userAccount)
                    self.performSegue(withIdentifier: self.segueLoginToMain, sender: nil)
                }catch(let error){
                    print("\(error.localizedDescription)")
                }
            }else{
                UIAlertController.showAlertController(title: nil,
                                                      massage: "이메일 또는 비밀번호가 잘못되었습니다.",
                                                      actionStyle: .default,
                                                      cancelBtn: false,
                                                      completion: nil)
            }
        }
        
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

