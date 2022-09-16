//
//  PostCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    public func setPostData(_ post: Photo, _ comments: [Comment]? = nil, _ postLikes: Int? = nil) {
        likesLabel.text = String(postLikes ?? post.likes)
        viewsLabel.text = String(post.views)
        commentsLabel.text = String(comments?.count ?? post.comments.count)
        NetworkImage.shared.setImage(url: post.image, imageview: postImageView)
        
        postImageView.layer.cornerRadius = 20
    }
}
