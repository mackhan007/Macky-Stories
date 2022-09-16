//
//  TermsAndConditionController.swift
//  MackyStories
//
//  Created by Aman on 08/09/22.
//

import Foundation
import UIKit
import WebKit

class TermsAndConditionController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        setupWebViewProgress()
    }
}

extension TermsAndConditionController {
    @IBAction func backOnClick() {
        self.dismiss(animated: true)
    }
    
    private func loadUrl() {
        progressBarView.isHidden = false
        progressBarView.progress = 0
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let TandCUrl = "https://www.apple.com/"
        let URL = URL(string: TandCUrl)
        guard let URL = URL else {
            return
        }

        let request = URLRequest(url: URL)
        webView.load(request)
    }
    
    private func setupWebViewProgress() {
        let observer = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressBarView.progress = Float(webView.estimatedProgress)
            
        }
    }
}

extension TermsAndConditionController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressBarView.progress = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progressBarView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
        self.dismiss(animated: true)
        let alert = AlertHelper.shared.showNormalAlert(title: "URL Error", message: "Error in Loading URL")
        
        self.present(alert, animated: true)
    }
}
