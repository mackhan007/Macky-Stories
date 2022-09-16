//
//  ChatViewController.swift
//  MackyStories
//
//  Created by Aman on 12/09/22.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todaysDateLabel: UILabel!
    
    private var userChatList: [UserLastMessage] = []
    private var isChatsLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        callAPI()
    }
}

extension ChatViewController {
    private func style() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    private func layout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ActiveIndicatorCell.reusableIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCell.reusableIdentifier)
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        
        todaysDateLabel?.text = dateFormatter.string(from: now)
    }
}

extension ChatViewController {
    // MARK: API
    private func callAPI() {
        APIManeger.shared.getUsersChats(complete: reloadUsers)
    }
    
    private func reloadUsers(_ chatList: [UserLastMessage]) {
        userChatList = chatList
        tableView.reloadData()
        
        isChatsLoading = false
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userChatList.count == 0 ? 1 : userChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isChatsLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveIndicatorCell.reusableIdentifier, for: indexPath)
            
            ActiveIndicatorCell.shared.getActiveIndicatorCell(cell)
            
            return cell
        }
        
        if userChatList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.reusableIdentifier, for: indexPath)
            
            EmptyCell.shared.getEmptyCell(cell)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatViewCell", for: indexPath) as! ChatCell
        let userChat = userChatList[indexPath.row]
        
        cell.setChatData(userChat)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
