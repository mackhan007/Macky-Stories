//
//  ViewController.swift
//  MackyStories
//
//  Created by Aman on 08/09/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: IBOUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    private var screenHeight = CGFloat(0)
    
    override func viewDidLoad() {
        checkLogin()
        
        super.viewDidLoad()
        
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        style()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Getters
    var userEmail: String? {
        return emailTextField.text
    }
    
    var userPassword: String? {
        return passwordTextField.text
    }
}

extension LoginViewController {
    @IBAction func forgotPasswordOnClick() {
        print("forgot")
        
        let backButton = UIBarButtonItem()
        backButton.title = "Log In"
        navigationItem.backBarButtonItem = backButton
    }
    
    @IBAction func signInOnClick(sender: UIButton) {
        sender.configuration?.imagePadding = 8
        sender.configuration?.showsActivityIndicator = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.login(sender)
        }
    }
    
    private func setDelegates() {
        passwordTextField.delegate = self
    }
    
    private func checkLogin() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: isUserLoggedInUserDefaults)
        
        if isLoggedIn {
            NavigationHelper.shared.gotoHomePage(navigationController: navigationController, false)
        }
    }
    
    private func login(_ sender: UIButton) {
        guard let email = userEmail, let password = userPassword else {
            assertionFailure("Email and password should never be nil")
            return
        }
        sender.configuration?.showsActivityIndicator = false
        
        if email.isEmpty || password.isEmpty || !ValidatorHelper.shared.validateEmail(email: email) {
            let alert = AlertHelper.shared.showNormalAlert(title: "Invalid Email / Password", message: "Please enter a Email and Password.")
            self.present(alert, animated: true)
            
            return
        }
        
        if !ValidatorHelper.shared.validateEmail(email: email) {
            let alert = AlertHelper.shared.showNormalAlert(title: "Invalid Email", message: "Please enter a valid Email.")
            self.present(alert, animated: true)
            
            return
        }
        
        if email.lowercased() == "test@gmail.com" && password == "password" {
            saveUserData()
            NavigationHelper.shared.gotoHomePage(navigationController: navigationController)
        } else {
            let alert = AlertHelper.shared.showNormalAlert(title: "Incorrect Email / password", message: "Please enter correct email and password")
            self.present(alert, animated: true)
        }
    }
    
    private func saveUserData() {
        UserDefaults.standard.set(true, forKey: isUserLoggedInUserDefaults)
    }
}

extension LoginViewController {
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            forgotPasswordButton.isHidden = true
        } else {
            forgotPasswordButton.isHidden = false
        }
    }
}
