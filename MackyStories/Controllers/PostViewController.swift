//
//  PostViewController.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class PostViewController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var keyBoardView: UIView!
    
    private var heartImageView: UIImageView?
    
    private var postComments: [Comment] = []
    private var postLikes: Int = 0
    private var isCommentsLoading = false
    
    public var userPost: Photo?
    public var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self)
    }
    
    var commentText: String {
        return commentTextField?.text ?? ""
    }
}

extension PostViewController {
    @IBAction func sendOnClick() {
        guard let user = currentUser else {
            return
        }
        
        if commentText.isEmpty {
            return
        }
        
        let comment = Comment(
            id: user.id,
            userName: user.name,
            userImage: user.userImage,
            comment: commentText,
            lastUpdated: Date().toString(dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        )
        
        postComments.append(comment)
        tableView.reloadData()
        commentTextField?.text = ""
    }
    
    func style() {
        // screen title
        tabBarController?.tabBar.isHidden = true
        
        title = userPost?.title.capitalized
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: nil
        )
    }
    
    private func layout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ActiveIndicatorCell.reusableIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCell.reusableIdentifier)
        
        postLikes = userPost?.likes ?? 0
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = KeyBoardHelper.shared.getKeyboardHeight(notification: notification)
        
        keyBoardView.setHeight(keyboardHeight - view.safeAreaInsets.bottom)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyBoardView.setHeight(0)
    }
    
    @objc func postImageViewOnDoubleClick() {
        postLikes += 1
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        heartImageView?.tintColor = .red
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.heartImageView?.tintColor = .systemGray
        }
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if postComments.count == 0 {
            return postComments.count + 3
        }
        
        return postComments.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postImageViewCell", for: indexPath) as! PostCell
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(postImageViewOnDoubleClick))
            doubleTap.numberOfTapsRequired = 1
            doubleTap.numberOfTapsRequired = 2
            cell.postImageView.addGestureRecognizer(doubleTap)
            
            heartImageView = cell.heartImageView
            
            if let userPost = userPost {
                cell.setPostData(userPost, postComments, postLikes)
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath)
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            
            return cell
        }
        
        if isCommentsLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveIndicatorCell.reusableIdentifier, for: indexPath)
            
            ActiveIndicatorCell.shared.getActiveIndicatorCell(cell)
            
            return cell
        }
        
        if postComments.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.reusableIdentifier, for: indexPath)
            
            EmptyCell.shared.getEmptyCell(cell, "No Comments available")
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        let postComment = postComments[indexPath.row - 2]
        
        cell.setPostData(postComment)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 30)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240
        }
        
        if indexPath.row == 1 {
            return tableView.rowHeight
        }
        
        return 110
    }
}
