//
//  SignUpController.swift
//  MackyStories
//
//  Created by Aman on 08/09/22.
//

import Foundation
import UIKit

class SignUpController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    private var screenHeight = CGFloat(0)
    
    
    private var isCheckTandC = true
    private let labelStr = "I agree with our Terms and Conditions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeTermsAndConditionsLabel()
        style()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Getters
    var userName: String? {
        return nameTextField.text
    }
    
    var userEmail: String? {
        return emailTextField.text
    }
    
    var userPassword: String? {
        return passwordTextField.text
    }
}

extension SignUpController {
    @IBAction func checkedOnClick(sender: UIButton) {
        isCheckTandC.toggle()
        
        if isCheckTandC {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func createAccountOnClick(sender: UIButton) {
        sender.configuration?.imagePadding = 8
        sender.configuration?.showsActivityIndicator = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.signUp(sender)
        }
    }
    
    @IBAction func signInOnClick() {
        navigationController?.popViewController(animated: true)
    }
    
    private func changeTermsAndConditionsLabel() {
        termsAndConditionsLabel.text = labelStr
        
        let greyColorTextAttribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.systemGray2]

        let blueLinkColorTextAttribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.systemBlue]
        
        let attributedString1 = NSMutableAttributedString(string: "I agree with our ", attributes: greyColorTextAttribute)
        let attributedString2 = NSMutableAttributedString(string: "Terms ", attributes: blueLinkColorTextAttribute)
        let attributedString3 = NSMutableAttributedString(string: "and ", attributes: greyColorTextAttribute)
        let attributedString4 = NSMutableAttributedString(string: "Conditions.", attributes: blueLinkColorTextAttribute)
        
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        termsAndConditionsLabel.attributedText = attributedString1
        termsAndConditionsLabel.isUserInteractionEnabled = true
        termsAndConditionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsAndConditionsOnClick)))
    }
    
    @objc private func termsAndConditionsOnClick(gresture: UITapGestureRecognizer) {
        let termsRange = (labelStr as NSString).range(of: "Terms and Conditions")
        
        if !gresture.didTapAttributedTextInLabel(label: termsAndConditionsLabel, inRange: termsRange) {
            return
        }
        
        
        let termsAndControllerVC = storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionController")
        termsAndControllerVC?.modalPresentationStyle = .popover
        guard let termsAndControllerVC = termsAndControllerVC else {
            return
        }
        
        self.present(termsAndControllerVC, animated: true)
    }
    
    private func signUp(_ sender: UIButton) {
        guard let name = userName, let email = userEmail, let password = userPassword else {
            assertionFailure("Name, Email and password should never be nil")
            return
        }
        sender.configuration?.showsActivityIndicator = false
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            let alert = AlertHelper.shared.showNormalAlert(title: "Invalid Name or Email or Password", message: "Please enter a valid Name, Email and Password!")
            self.present(alert, animated: true)
            
            return
        }
        
        if !ValidatorHelper.shared.validateEmail(email: email) {
            let alert = AlertHelper.shared.showNormalAlert(title: "Invalid Email", message: "Please enter a valid Email.")
            self.present(alert, animated: true)
            
            return
        }
        
        if !isCheckTandC {
            let alert = AlertHelper.shared.showNormalAlert(title: "Terms and Conditions", message: "Please accept the Terms and Conditions before signing up.")
            self.present(alert, animated: true)
            
            return
        }
        
        NavigationHelper.shared.gotoHomePage(navigationController: navigationController)
    }
}

extension SignUpController {
    // MARK: Keyboard
    
    private func style() {
        navigationController?.navigationBar.isHidden = true
        
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
