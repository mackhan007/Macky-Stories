//
//  CommentCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    private func getDate(_ date: String) -> Date? {
        let dateFormatterUK = DateFormatter()
        dateFormatterUK.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let stringDate = date.components(separatedBy: ".").first {
            let date = dateFormatterUK.date(from: stringDate)
            
            return date
        }
        
        return nil
    }
    
    public func setPostData(_ comment: Comment) {
        userNameLabel.text = comment.userName
        commentLabel.text = comment.comment
        timeAgoLabel.text = getDate(comment.lastUpdated)?.timeAgoDisplay()
        NetworkImage.shared.setImage(url: comment.userImage, imageview: userImageView)
        
        userImageView.layer.cornerRadius = 23
    }
}
