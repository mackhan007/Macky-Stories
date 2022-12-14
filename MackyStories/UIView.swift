//
//  UIView.swift
//  MackyStories
//
//  Created by Aman on 09/09/22.
//

import Foundation
import UIKit

extension UIView {
    func setHeight(_ h: CGFloat, animateTime: TimeInterval?=nil) {

        if let c = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
            c.constant = CGFloat(h)

            if let animateTime = animateTime {
                UIView.animate(withDuration: animateTime, animations:{
                    self.superview?.layoutIfNeeded()
                })
            }
            else {
                self.superview?.layoutIfNeeded()
            }
        }
    }
}
