//
//  Post.swift
//  MackyStories
//
//  Created by Aman on 09/09/22.
//

import Foundation

struct Post: Codable {
    
    let id: String
    let userName: String
    let userId: String
    let userImage: String
    let postImage: String
    let owner: String
    let description: String
    let tags: String
    let createdAt: String
    let comments: [String] = []
    let views: Int
    var likes: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userName = "name"
        case userId = "user_id"
        case userImage = "avatar"
        case postImage = "image"
        case tags
        case comments
        case views
        case owner
        case description
        case likes
        case createdAt
    }
}
