//
//  Extension.swift
//  ForestClone

import UIKit

extension Notification {
    
}

// MARK: UIAlertCotroller
extension UIAlertController {
    static func showAlertController(title: String?,
                                    massage: String?,
                                    actionStyle: UIAlertActionStyle = UIAlertActionStyle.default,
                                    cancelBtn: Bool,
                                    completion: ((UIAlertAction)->Void)?)
    {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: actionStyle, handler: completion)
        alert.addAction(okAction)
        if cancelBtn {
            let cancelAction = UIAlertAction(title: "취소", style: actionStyle, handler: completion)
            alert.addAction(cancelAction)
        }
        
    }
}
