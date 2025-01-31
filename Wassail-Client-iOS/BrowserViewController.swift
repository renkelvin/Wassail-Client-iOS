//
//  BrowserViewController.swift
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 9/25/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

import UIKit

class BrowserViewController: GAITrackedViewController {
    
    @IBOutlet var navigationView: UIView?
    
    var address: NSString = ""
    var url: NSURL?
    var request: NSURLRequest?
    
    var maxdata: Int = 0
    var curdata: Int = 0
    
    @IBOutlet var webView: UIWebView?
    
    @IBOutlet var indicator: UIActivityIndicatorView?
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var urlLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.url = NSURL(string: address as String)
        self.request = NSURLRequest(URL: self.url!)
        
        // Load request
        webView!.loadRequest(self.request!)
        
        //
        webView!.scalesPageToFit = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // GAITrackedViewController name
        self.screenName = "Browser Screen"
        
        // Configure Navigation Bar and Status Bar
        self.setNavigationBarStyle(HLNavigationBarStyle.TransparentWithDarkText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    
    override func setInfo(info: AnyObject?) {
        if (info != nil) {
            address = info as! NSString
        }
    }
    
    // MARK: - UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //        println("Webview should start: \(request.URL)")
        
        //        self.connection = NSURLConnection(request: self.request!, delegate: self)
        //        self.connection?.start()
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        //        println("Webview did start")
        
        self.urlLabel!.text = self.request!.URL!.absoluteString
        
        self.indicator!.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        //        println("Webview did finish")
        
        self.titleLabel!.text = webView.stringByEvaluatingJavaScriptFromString("document.title")
        
        self.indicator!.stopAnimating()
        self.indicator!.hidden = true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        
        print("Webview did failed: \(error)")
        
        self.indicator!.stopAnimating()
        self.indicator!.hidden = true
        
        // TODO: Handle
    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
