//
//  Photo.swift
//  MackyStories
//
//  Created by Aman on 09/09/22.
//

import Foundation

struct Photo: Codable {
    
    let id: String
    let userId: String
    let title: String
    let image: String
    let postId: String
    let createdAt: String
    let comments: [String]
    let views: Int
    let likes: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case comments
        case views
        case likes
        case image
        case postId = "post_id"
        case createdAt
    }
}
