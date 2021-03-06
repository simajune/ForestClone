
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
    //    @IBOutlet weak var contentView: UIView!
    
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
                let account = Account(email: email, pwd: pwd)
                do{
                    let data = try JSONEncoder().encode(account)
                    KeychainWrapper.standard.set(data, forKey: userAccount)
                    self.performSegue(withIdentifier: self.segueLoginToMain, sender: nil)
                }catch (let error){
                    print("\(error.localizedDescription)")
                }
            }else{
                UIAlertController.presentAlertController(target: self,
                                                         title: nil,
                                                         massage: "이메일 또는 비밀번호가 잘못되었습니다.", actionStyle: .default, cancelBtn: false, completion: nil)
            }
        }
        
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        pwdTF.delegate = self
        
        // 키보드 올리기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        // 키보드 내리기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillhide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        // 탭했을 경우 키보드 내리기
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backGroundTapKeyboardHide(_:))))
    }
}

// MARK: extension LoginViewController
extension LoginViewController {
    // MARK: 키보들 보일때
    @objc func keyboardWillshow(_ sender: Notification) {
        self.view.bounds.origin.y = -50
    }
    //MARK: 키보드 내릴때
    @objc func keyboardWillhide(_ sender: Notification) {
        self.view.bounds.origin.y = 0
    }
    
    // MARK: 키보드 탭 제스쳐
    @objc func backGroundTapKeyboardHide(_ tap: UITapGestureRecognizer){
        if emailTF.isFirstResponder {
            emailTF.resignFirstResponder()
        }else if pwdTF.isFirstResponder{
            pwdTF.resignFirstResponder()
        }
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    // done(return)을 누를 경우
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pwdTF.resignFirstResponder()
        return true
    }
}
