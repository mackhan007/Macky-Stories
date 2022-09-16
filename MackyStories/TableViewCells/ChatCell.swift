//
//  ChatCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import UIKit

class ChatCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    
    private func getDate(_ date: String) -> Date? {
        let dateFormatterUK = DateFormatter()
        dateFormatterUK.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let stringDate = date.components(separatedBy: ".").first {
            let date = dateFormatterUK.date(from: stringDate)
            
            return date
        }
        
        return nil
    }
    
    public func setChatData(_ lastMessage: UserLastMessage) {
        userNameLabel.text = lastMessage.name
        userTextLabel.text = lastMessage.lastMessage
        NetworkImage.shared.setImage(url: lastMessage.userImage, imageview: userImageView)
        dateLabel.text = getDate(lastMessage.lastUpdated)?.timeAgoDisplay()
        
        userImageView.layer.cornerRadius = 23
    }
}
