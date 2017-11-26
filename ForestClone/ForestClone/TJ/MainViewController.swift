
import UIKit
import Foundation
import HGCircularSlider
import CountdownLabel

class MainViewController: UIViewController {
    //MARK: - Property
    //나중에 버튼은 태크처리하기
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var treeBtn: UIButton!
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    @IBOutlet weak var medalBtn: UIButton!
    @IBOutlet weak var marketBtn: UIButton!
    @IBOutlet weak var sproutsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var cashBGView: UIView!
    @IBOutlet weak var mainCircleSlider: CircularSlider!
    @IBOutlet weak var countdownLb: CountdownLabel!
    @IBOutlet weak var plantBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeBtn()
        mainCircleSlider.addTarget(self, action: #selector(textUpdate), for: .valueChanged)
    }
    
    private func initializeBtn() {
        menuBtn.isSelected = false
        treeBtn.alpha = 0
        tagBtn.alpha = 0
        friendsBtn.alpha = 0
        medalBtn.alpha = 0
        marketBtn.alpha = 0
        sproutsBtn.alpha = 0
        settingsBtn.alpha = 0
        cashBGView.layer.cornerRadius = 11
        plantBtn.layer.cornerRadius = 5
        textUpdate()
    }
    
    @objc func textUpdate() {
        let seconds = Double(mainCircleSlider.endPointValue)
        countdownLb.setCountDownTime(minutes: seconds)
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        if menuBtn.isSelected {
            buttonHidden()
        }else {
            buttonAppear()
        }
    }
    
    private func buttonHidden() {
        UIView.animate(withDuration: 0.3) {
            self.treeBtn.alpha = 0
            self.tagBtn.alpha = 0
            self.friendsBtn.alpha = 0
            self.medalBtn.alpha = 0
            self.marketBtn.alpha = 0
            self.sproutsBtn.alpha = 0
            self.settingsBtn.alpha = 0
            self.menuBtn.isSelected = false
        }
    }
    
    private func buttonAppear() {
        UIView.animate(withDuration: 0.3) {
            self.treeBtn.alpha = 1
            self.tagBtn.alpha = 1
            self.friendsBtn.alpha = 1
            self.medalBtn.alpha = 1
            self.marketBtn.alpha = 1
            self.sproutsBtn.alpha = 1
            self.settingsBtn.alpha = 1
            self.menuBtn.isSelected = true
        }
    }

}
