//
//  VKLoginViewController.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 16.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!{
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7568884"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
    
}

extension VKLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, parameter in
                var dict = result
                let key = parameter[0]
                let value = parameter[1]
                dict[key] = value
                return dict
        }
        
        guard let token = parameters["access_token"],
            let userIdString = parameters["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        Session.shared.token = token
        
//        let targetVC = (storyboard?.instantiateViewController(identifier: "TabBar"))!
//        targetVC.modalPresentationStyle = .fullScreen
//        self.present(targetVC, animated: true, completion: nil)
//        
        performSegue(withIdentifier: "showTabBar", sender: nil)
        
        decisionHandler(.cancel)
        
    }
    
}
