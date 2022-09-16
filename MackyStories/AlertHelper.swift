//
//  AlertHelper.swift
//  MackyStories
//
//  Created by Aman on 08/09/22.
//

import Foundation
import UIKit

class AlertHelper {
    
    // MARK: Singleton
    public static let shared = AlertHelper()
    
    public func showNormalAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
