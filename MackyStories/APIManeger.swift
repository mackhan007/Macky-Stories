//
//  APIManeger.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import Alamofire

class APIManeger {
    
    // MARK: Singleton
    public static let shared = APIManeger()
    
    public func getUserData(complete: @escaping (_: User) -> Void)  {
        let request = AF.request(userUrl)
        
//        request.responseDecodable(of: [User].self) { data in
//            switch data.result {
//                case .success(let data):
//                    print(data)
//                case .failure(let data):
//                    print(data)
//            }
//        }
        
        request.validate().responseDecodable(of: [User].self) { res in
            guard let user = res.value else {
                return
            }
            
            complete(user.first!)
        }
    }
    
    public func getUserPosts(complete: @escaping (_: [Photo]) -> Void, userId: String) {
        let request = AF.request(getUserPostsUrl(userId))
        
        request.validate().responseDecodable(of: [Photo].self) { res in
            guard let posts = res.value else {
                return
            }
            
            complete(posts)
        }
    }
    
    public func getUsersChats(complete: @escaping (_: [UserLastMessage]) -> Void) {
        let request = AF.request(friendsUrl)
        
        request.validate().responseDecodable(of: [UserLastMessage].self) { res in
            guard let userFriends = res.value else {
                return
            }
            
            complete(userFriends)
        }
    }
    
    public func getOtherUserPosts(complete: @escaping (_: [Post]) -> Void) {
        let request = AF.request(postsURL)
        
        request.validate().responseDecodable(of: [Post].self) { res in
            guard let otherUserPosts = res.value else {
                return
            }
            
            complete(otherUserPosts)
        }
    }
}
