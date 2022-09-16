//
//  testController.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class testController: UIViewController {
    
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    private var screenHeight = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        screenHeight = view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        
        mainView.setHeight(screenHeight)
        
        registerKeyboardNotifications()
    }
}

extension testController {
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardDidShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let keyboardHeight = keyboardSize.height
        
        mainView.setHeight(screenHeight + keyboardHeight)
        keyBoardView.setHeight(keyboardHeight)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyBoardView.setHeight(0)
        mainView.setHeight(screenHeight)
    }
}
