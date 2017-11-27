
import UIKit
import Firebase
import SwiftKeychainWrapper

class SignupViewController: UIViewController {
    
    // MARK: IBAction
    @IBAction func signUpBtn(_ sender: UIButton){
        guard let email = emailTF.text, !email.isEmpty else{
            UIAlertController.presentAlertController(target: self,
                                                     title: "이메일을 입력해주세요,",
                                                     massage: nil,
                                                     cancelBtn: false,
                                                     completion: nil)
            return
        }
        guard let pwd = pwdTF.text, !pwd.isEmpty else{
            UIAlertController.presentAlertController(target: self,
                                                     title: "비밀번호를 입력해주세요.",
                                                     massage: nil,
                                                     cancelBtn: false,
                                                     completion: nil)
            return
        }
        guard let rePwd = rePwdTF.text, !rePwd.isEmpty else{
            UIAlertController.presentAlertController(target: self,
                                                     title: "비밀번호를 다시 입력해주세요.",
                                                     massage: nil,
                                                     cancelBtn: false,
                                                     completion: nil)
            return
        }
        guard let nickName = nickNamdTF.text, !nickName.isEmpty else{
            UIAlertController.presentAlertController(target: self,
                                                     title: "닉네임을 입력해주세요.",
                                                     massage: nil,
                                                     cancelBtn: false,
                                                     completion: nil)
            return
        }
        if pwd != rePwd {
            UIAlertController.presentAlertController(target: self,
                                                     title: "비밀번호가 다릅니다.",
                                                     massage: nil,
                                                     cancelBtn: false,
                                                     completion: nil)
        }else{
            Auth.auth().createUser(withEmail: email, password: pwd, completion: { [weak self] (user, error) in
                guard let `self` = self else { return }
                if error == nil, let user = user{
                    let account = Account(email: email, pwd: pwd)
                    if let data = try? JSONEncoder().encode(account) {
                        KeychainWrapper.standard.set(data, forKey: userAccount)
                    }
                    let profileChangeRequest = user.createProfileChangeRequest()
                    profileChangeRequest.displayName = nickName
                    profileChangeRequest.commitChanges(completion: nil) 
                    
                    let userDictionary : [String: Any] = ["user":["email": user.email,"nickname": nickName]]
                    self.reference.child(user.uid).setValue(userDictionary)
                    UIAlertController.presentAlertController(target: self,
                                                             title: "가입축하",
                                                             massage: "가입을 축하드립니다.",
                                                             actionStyle: .default,
                                                             cancelBtn: false,
                                                             completion: { _ in
                                                                self.performSegue(withIdentifier: self.segueSignUpToMain, sender: nil)
                    })
                }
            })
        }
    }
    
    // MARK: IBOutlet
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var rePwdTF: UITextField!
    @IBOutlet weak var nickNamdTF: UITextField!
    
    // MARK: Property
    lazy var reference = Database.database().reference()
    let segueSignUpToMain = "segueSignUpToMain"
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 올리기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        // 키보드 내리기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillhide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        // 탭했을 경우 키보드 내리기
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backGroundTapKeyboardHide(_:))))
    }
    
}
// MARK: extension LoginViewController
extension SignupViewController {
    // MARK: 키보들 보일때
    @objc func keyboardWillshow(_ sender: Notification) {
        self.view.bounds.origin.y = -80
    }
    //MARK: 키보드 내릴때
    @objc func keyboardWillhide(_ sender: Notification) {
        self.view.bounds.origin.y = 0
    }
    // MARK: 키보드 탭 제스쳐
    @objc func backGroundTapKeyboardHide(_ tap: UITapGestureRecognizer){
        for view in view.subviews {
            view.endEditing(true)
        }
    }
}

// MARK: UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    
    // done(return)을 누를 경우
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         rePwdTF.resignFirstResponder()
//        for view in view.subviews {
//            view.resignFirstResponder()
//        }
        return true
    }
}

