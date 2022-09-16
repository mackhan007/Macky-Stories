//
//  UserPostCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import UIKit

class UserPostCell: UICollectionViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    public func setUserPostData(_ photo: Photo) {
        likesLabel.text = String(photo.likes)
        postTitleLabel.text = photo.title
        NetworkImage.shared.setImage(url: photo.image, imageview: postImageView)
        
        postImageView.layer.cornerRadius = 15
    }
}
