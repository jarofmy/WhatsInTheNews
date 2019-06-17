//
//  DetailViewController.swift
//  WhatsInTheNews
//
//  Created by Jeremy Van on 2/15/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var news: NewsItem!
    var webView: WKWebView!
    var indicator = UIActivityIndicatorView()

    
    override func viewDidLayoutSubviews() {
        let frame = CGRect(x: 0, y: view.frame.height - 80, width: webView.frame.width, height: 80)
        let sourceView = UIView(frame: frame)
        sourceView.backgroundColor = .cyan
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: webView.frame.width, height: 60))
        label.textAlignment = .center
        UIFont.boldSystemFont(ofSize: 20)
        guard let sourceName = news?.source?.name else {return}
        label.text = sourceName
        sourceView.addSubview(label)
        webView.addSubview(sourceView)
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = news?.url else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 46, height: 46))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
//        self.view.addSubview(indicator)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
