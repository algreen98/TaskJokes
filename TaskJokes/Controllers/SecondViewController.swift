//
//  SecondViewController.swift
//  TaskJokes
//
//  Created by mac on 23.01.2021.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://www.icndb.com/api/"
        let url = URL(string: urlString)
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        
        //self.view.backgroundColor = .gray
        self.title = "API"
        
    }
}
