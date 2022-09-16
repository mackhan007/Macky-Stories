//
//  Friend.swift
//  MackyStories
//
//  Created by Aman on 09/09/22.
//

import Foundation

struct Friend: Codable {
    
    let id: String
    let name: String
    let userImage: String
    let lastMessage: String
    let lastUpdated: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case userImage = "avatar"
        case lastMessage
        case lastUpdated
    }
}
