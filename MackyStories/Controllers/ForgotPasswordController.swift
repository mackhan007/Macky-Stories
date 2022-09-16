//
//  ForgotPasswordController.swift
//  MackyStories
//
//  Created by Aman on 08/09/22.
//

import Foundation
import UIKit

class ForgotPasswordController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    private var screenHeight = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Password reset"
        style()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        parent?.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Getters
    var userEmail: String? {
        return emailTextField.text
    }
}

extension ForgotPasswordController {
    @IBAction func continueOnClick() {
        guard let email = userEmail else {
            assertionFailure("Email should not be nil")
            
            return
        }
        
        if email.isEmpty {
            let alert = AlertHelper.shared.showNormalAlert(title: "Email empty", message: "Please enter a email.")
            self.present(alert, animated: true)
            
            return
        }
        
        if ValidatorHelper.shared.validateEmail(email: email) {
            navigationController?.popViewController(animated: true)
        } else {
            let alert = AlertHelper.shared.showNormalAlert(title: "Invalid Email", message: "Please enter a valid email.")
            self.present(alert, animated: true)
        }
    }
}

extension ForgotPasswordController {
    // MARK: Keyboard
    
    private func style() {
        navigationController?.navigationBar.isHidden = false
        
        /// explanation for delay: we need some time for geting safeAreaInsets and we have added this delay
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setMainViewHeight()
        }
        registerKeyboardNotifications()
    }
    
    private func setMainViewHeight() {
        screenHeight = view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        
        mainView.setHeight(screenHeight)
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = KeyBoardHelper.shared.getKeyboardHeight(notification: notification)
        
        mainView.setHeight(screenHeight + keyboardHeight)
        keyBoardView.setHeight(keyboardHeight)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyBoardView.setHeight(0)
        setMainViewHeight()
    }
}
