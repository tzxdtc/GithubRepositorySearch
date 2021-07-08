//
//  WebViewViewController.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/08.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    var webView: WKWebView!
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        super.loadView()

        self.webView = WKWebView()
        self.view = self.webView!
    }
}
