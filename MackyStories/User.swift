//
//  User.swift
//  MackyStories
//
//  Created by Aman on 09/09/22.
//

import Foundation

struct User: Codable {
    
    let id: String
    let name: String
    let userImage: String
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case userImage = "avatar"
        case createdAt
    }
}
