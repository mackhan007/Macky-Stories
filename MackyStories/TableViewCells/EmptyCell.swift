//
//  EmptyCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class EmptyCell {
    
    // MARK: Singleton
    public static let shared = EmptyCell()
    public static let reusableIdentifier = "emptyCell"
    
    public func getEmptyCell(_ cell: UITableViewCell, _ emptyCellLabel: String? = nil) {
        cell.textLabel?.text = emptyCellLabel ?? "Empty Cell"
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }
}
