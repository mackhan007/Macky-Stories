//
//  NetworkImage.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class NetworkImage {
    
    // MARK: Singleton
    public static let shared = NetworkImage()
    
    public func setImage(url: String, imageview: UIImageView) {
        guard let url = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                imageview.image = UIImage(data: data!)
            }
        }
    }
}
