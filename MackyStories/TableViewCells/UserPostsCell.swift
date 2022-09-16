//
//  UserPostsCell.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class UserPostsCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        postsCollectionView.delegate = dataSourceDelegate
        postsCollectionView.dataSource = dataSourceDelegate
        postsCollectionView.tag = row
        postsCollectionView.reloadData()
    }
}
