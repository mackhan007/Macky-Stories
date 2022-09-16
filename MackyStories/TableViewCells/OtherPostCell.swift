//
//  OtherPostCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import UIKit

class OtherPostCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    private func getDate(_ date: String) -> Date? {
        let dateFormatterUK = DateFormatter()
        dateFormatterUK.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let stringDate = date.components(separatedBy: ".").first {
            let date = dateFormatterUK.date(from: stringDate)
            
            return date
        }
        
        return nil
    }
    
    private func setStyle() {
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        mainView.layer.cornerRadius = 20
        
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.systemBlue.cgColor
        followButton.layer.cornerRadius = 12
        
        postImageView.layer.cornerRadius = 20
        userImageView.layer.cornerRadius = 20
    }
    
    public func setPostData(_ post: Post) {
        setStyle()
        
        userNameLabel.text = post.userName
        timeAgoLabel.text = getDate(post.createdAt)?.timeAgoDisplay()
        descriptionLabel.text = post.description
        
        let tagComponents = post.tags.components(separatedBy: " ")
        if tagComponents.count > 0 {
            tagsLabel.text = "#\(tagComponents.joined(separator: " #"))"
        }
        
        NetworkImage.shared.setImage(url: post.userImage, imageview: userImageView)
        NetworkImage.shared.setImage(url: post.postImage, imageview: postImageView)
    }
}
