//
//  InfoViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import WebKit
import PureLayout
import NVActivityIndicatorView

class WebViewController: KasperViewController, WKUIDelegate, WKNavigationDelegate{

    var webview : WKWebView!
    var url : String! = "http://google.com"
    var canNavigate : Bool = false
    var isLocal : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        
        webview = WKWebView.init(frame: self.view.frame, configuration: webConfiguration)
        self.view.addSubview(self.webview)
        self.webview.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.webview.autoPinEdgesToSuperviewEdges()
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        self.webview.contentMode = .scaleAspectFill
        
        if !isLocal {
            self.startAnimating()
            self.webview.load(URLRequest.init(url: URL.init(string: url)!))
        }else {
            let fileurl = URL(fileURLWithPath: self.url)
            self.webview.loadFileURL(fileurl, allowingReadAccessTo: fileurl)
            
        }
        

        // Do any additional setup after loading the view.
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("www.google.com"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(url)
                }
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
    

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
