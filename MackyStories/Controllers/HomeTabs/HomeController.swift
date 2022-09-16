//
//  HomeController.swift
//  MackyStories
//
//  Created by Aman on 11/09/22.
//

import Foundation
import UIKit

class HomeController: UIViewController {

    // MARK: IBOUTLETS
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var currentUser: User?
    private var userPosts: [Photo] = []
    private var otherUsersPosts: [Post] = []
    
    private var areUserPostsLoading = true
    private var areOtherPostsLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        callAPI()
    }
}

extension HomeController {
    @objc private func userOnClick() {
        NavigationHelper.shared.gotoLoginPage(navigationController: navigationController)
    }
    
    private func style() {
        // navbar items
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
        
        // user image
        userImageView.layer.cornerRadius = 15
    }
    
    private func layout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCell.reusableIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ActiveIndicatorCell.reusableIdentifier)
        tableView.register(ActiveIndicatorCellNew.self, forCellReuseIdentifier: ActiveIndicatorCellNew.reusableIdentifier)
        
        userImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userOnClick)))
    }
}

extension HomeController {
    // MARK: API
    private func callAPI() {
        APIManeger.shared.getUserData(complete: completeUser)
        APIManeger.shared.getOtherUserPosts(complete: completePosts)
        APIManeger.shared.getUserPosts(complete: completeUserPosts, userId: "1")
    }
    
    private func completeUser(_ user: User) {
        currentUser = user
        NetworkImage.shared.setImage(url: user.userImage, imageview: userImageView)
    }
    
    private func completeUserPosts(_ posts: [Photo]) {
        userPosts = posts
        areUserPostsLoading = false
        tableView.reloadData()
    }
    
    private func completePosts(_ otherPosts: [Post]) {
        otherUsersPosts = otherPosts
        areOtherPostsLoading = false
        tableView.reloadData()
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if otherUsersPosts.count == 0 {
            return otherUsersPosts.count + 3
        }
        
        return otherUsersPosts.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if areUserPostsLoading {
                let cell = tableView.dequeueReusableCell(withIdentifier: ActiveIndicatorCellNew.reusableIdentifier, for: indexPath)
                
//                ActiveIndicatorCell.shared.getActiveIndicatorCell(cell)
                
                return cell
            }
            
            if userPosts.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.reusableIdentifier, for: indexPath)
                
                EmptyCell.shared.getEmptyCell(cell)
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "userPhotos", for: indexPath) as! UserPostsCell
            
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherPostTagCell", for: indexPath)
            
            return cell
        }
        
        if areOtherPostsLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveIndicatorCellNew.reusableIdentifier, for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! OtherPostCell
        let otherUserPost = otherUsersPosts[indexPath.row - 2]
        
        cell.setPostData(otherUserPost)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        
        return tableView.rowHeight
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPostsCell", for: indexPath) as! UserPostCell
        let userPost = userPosts[indexPath.row]
        
        cell.setUserPostData(userPost)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userPost = userPosts[indexPath.row]
        
        NavigationHelper.shared.gotoUserPostPage(navigationController: navigationController, userPost, currentUser)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 128)
    }
}
