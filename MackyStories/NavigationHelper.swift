//
//  NavigationHelper.swift
//  MackyStories
//
//  Created by Aman on 11/09/22.
//

import Foundation
import UIKit

class NavigationHelper {
    
    // MARK: Singleton
    public static let shared = NavigationHelper()
    
    public func gotoHomePage(navigationController: UINavigationController?, _ animate: Bool = true) {
        let homeTabViewControllerVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabViewController") as? HomeTabViewController
        
        guard let homeTabViewControllerVC = homeTabViewControllerVC else {
            return
        }
        homeTabViewControllerVC.modalPresentationStyle = .fullScreen
        
        navigationController?.present(homeTabViewControllerVC, animated: animate)
    }
    
    public func gotoUserPostPage(navigationController: UINavigationController?, _ userPost: Photo? = nil, _ currentUser: User? = nil) {
        let userPostVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController
        
        guard let userPostVC = userPostVC else {
            return
        }
        
        userPostVC.userPost = userPost
        userPostVC.currentUser = currentUser
        
        navigationController?.pushViewController(userPostVC, animated: true)
    }
    
    public func gotoLoginPage(navigationController: UINavigationController?) {
        UserDefaults.standard.removeObject(forKey: isUserLoggedInUserDefaults)
        UserDefaults.standard.synchronize()
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        guard let loginVC = loginVC else {
            return
        }
        
        navigationController?.tabBarController?.tabBar.isHidden = true
        
        loginVC.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}
