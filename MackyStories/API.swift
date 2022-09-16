//
//  API.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation

let APIOrigin = "https://63197d298e51a64d2be58270.mockapi.io/api/v1/"
let userUrl = APIOrigin + "user"
let friendsUrl = APIOrigin + "friends"
let postsURL = APIOrigin + "posts"

func getUserPostsUrl(_ userId: String) -> String {
    return APIOrigin + "user/\(userId)/photos"
}
