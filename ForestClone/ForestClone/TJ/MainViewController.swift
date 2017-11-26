
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var treeBtn: UIButton!
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    @IBOutlet weak var medalBtn: UIButton!
    @IBOutlet weak var marketBtn: UIButton!
    @IBOutlet weak var sproutsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.isSelected = false
        treeBtn.alpha = 0
        tagBtn.alpha = 0
        friendsBtn.alpha = 0
        medalBtn.alpha = 0
        marketBtn.alpha = 0
        sproutsBtn.alpha = 0
        settingsBtn.alpha = 0
        
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
