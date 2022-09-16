//
//  Comment.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation

struct Comment: Codable {
    
    let id: String
    let userName: String
    let userImage: String
    let comment: String
    let lastUpdated: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userName
        case userImage = "avatar"
        case comment
        case lastUpdated
    }
}
