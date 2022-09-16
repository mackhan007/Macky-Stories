//
//  ValidatorHelper.swift
//  MackyStories
//
//  Created by Aman on 08/09/22.
//

import Foundation

class ValidatorHelper {
    
    // MARK: Singleton
    public static let shared = ValidatorHelper()
    
    public func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
