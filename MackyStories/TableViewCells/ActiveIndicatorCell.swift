//
//  ActiveIndicatorCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class ActiveIndicatorCell {
    
    // MARK: Singleton
    public static let shared = ActiveIndicatorCell()
    public static let reusableIdentifier = "activeIndicator"
    
    public func getActiveIndicatorCell(_ cell: UITableViewCell) {
        let activeIndicatorView = UIActivityIndicatorView()
        activeIndicatorView.startAnimating()
    
        cell.accessoryView = activeIndicatorView
        cell.accessoryView?.bounds = cell.bounds
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }
}

class ActiveIndicatorCellNew: UITableViewCell {
    public static let reusableIdentifier = "activeNewIndicator"
    private var activeIndicator: UIActivityIndicatorView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        activeIndicator = UIActivityIndicatorView()
        activeIndicator?.startAnimating()
        
        if activeIndicator != nil {
            contentView.addSubview(activeIndicator!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activeIndicator?.frame = CGRect(x: contentView.center.x, y: contentView.center.y, width: 30, height: 30)
    }
}
