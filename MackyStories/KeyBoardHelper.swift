//
//  KeyBoardHelper.swift
//  MackyStories
//
//  Created by Aman on 13/09/22.
//

import Foundation
import UIKit

class KeyBoardHelper {
    
    // MARK: Singleton
    public static let shared = KeyBoardHelper()
    
    public func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        return keyboardSize.height
    }
}
