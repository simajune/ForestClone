//
//  Extension.swift
//  ForestClone

import UIKit

class LoginAndSignUpView: UIView {
   
     // MARK: 버튼
    @IBOutlet weak var signUpBtn: UIButton? // 회원가입페이지로 넘어가는 버튼
    @IBOutlet weak var logInBtn: UIButton? // 로그인 버튼
    @IBOutlet weak var newMemberBtn: UIButton? // 회원가입등록버튼
    
    //MARK: 텍스트필드
    @IBOutlet weak var emailTF: UITextField?
    @IBOutlet weak var pwdTF: UITextField?
    @IBOutlet weak var newEmailTF: UITextField?
    @IBOutlet weak var newPwdTF: UITextField?
    @IBOutlet weak var newRePwdTF: UITextField?
    @IBOutlet weak var newNickNameTF: UITextField?
    
    // MARK: Login + SignUp View Setting
    override func awakeFromNib() {

    }
    
    // MARK: Login + SignUp View Setting
    override func layoutSubviews() {
        
        logInBtn?.buttonLayer(cornerRadius: 10, borderWidth: 2, borderColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        signUpBtn?.buttonLayer(cornerRadius: 10, borderWidth: 2, borderColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        newMemberBtn?.buttonLayer(cornerRadius: 10, borderWidth: 2, borderColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        
        emailTF?.addBorderBottom(height: 1, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        pwdTF?.addBorderBottom(height: 1, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        newEmailTF?.addBorderBottom(height: 1, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        newPwdTF?.addBorderBottom(height: 1, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        newRePwdTF?.addBorderBottom(height: 1, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        newNickNameTF?.addBorderBottom(height: 1, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        
    }
}
// MARK: UIButton
extension UIButton {
    
    func buttonLayer(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
//        let layer = CALayer()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
//        self.layoutIfNeeded()
//        self.layer.addSublayer(layer) // ???
    }
}

// MARK: UITextField
extension UITextField{
    // MARK: 텍스트필드 밑줄 
    func addBorderBottom(height:CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
