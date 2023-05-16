//
//  ViewController.swift
//  Menu
//
//  Created by 刘至秦 on 2023/4/19.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var navigationBar: UIStackView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        showHomePage()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
        let topConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
        
        setNavigationBtnsStatus()
    }
    
    func setNavigationBtnsStatus() {
        backBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
    }
    
    func showHomePage() {
        let url = NSURL(string: "https://www.cgmmedical.jp")
        let request = NSURLRequest(url: url! as URL)
        webView.load(request as URLRequest)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let url = navigationAction.request.url?.absoluteString
        if (url != nil && url!.hasSuffix(".pdf")) {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setNavigationBtnsStatus()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        setNavigationBtnsStatus()
    }
    
    @IBAction func backClick(_ sender: Any) {
        webView.goBack()
    }
    
    
    @IBAction func forwardClick(_ sender: Any) {
        webView.goForward()
    }
    
    
    @IBAction func homeClick(_ sender: Any) {
        showHomePage()
    }
    
    
    @IBAction func refreshClick(_ sender: Any) {
        webView.reload()
    }
}

