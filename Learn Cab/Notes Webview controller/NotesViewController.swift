//
//  NotesViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 21/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import VGPlayer
import SnapKit
import SDWebImage
import WebKit

class NotesViewController: UIViewController,UIWebViewDelegate{
    var discription : String!
    var notes : String!
    var titlestr : String!
    var url : URL?
    @IBOutlet weak var webview : UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.navigationItem.title = titlestr
        
        let url = URL(string: notes)
        let path = Bundle.main.url(forResource: notes, withExtension: "svg")
        print(path)
//        if path != "" {
            let fileURL:URL = URL(fileURLWithPath: notes)
            let req = URLRequest(url: fileURL)
           // self.webview.scalesPageToFit = false
            self.webview.loadRequest(req)
//        }
//        else {
//            //handle here if path not found
//        }

        
        webview.delegate = self as! UIWebViewDelegate
        webview.scrollView.isScrollEnabled = true
        webview.contentMode = .scaleAspectFit
        webview.backgroundColor = .clear
        webview.scrollView.maximumZoomScale = 2
        webview.scrollView.minimumZoomScale = 1
        webview.scalesPageToFit = true
        //addSubview(webview)
        webview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.load(url: notes)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
        func load(url: String) {
            webview.stopLoading()
            if let url = URL(string: notes) {
                webview.loadRequest(URLRequest(url: url))
            }
        }
    
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
//    extension NotesViewController: UIWebViewDelegate {
//        public func webViewDidFinishLoad(_ webView: UIWebView) {
//            let zoom = webView.bounds.size.width / webView.scrollView.contentSize.width
////            webView.scrollView.minimumZoomScale = zoom
////            webView.scrollView.maximumZoomScale = zoom
////            webView.scrollView.setZoomScale(zoom, animated: true)
//            let scaleFactor = webView.bounds.size.width / webView.scrollView.contentSize.width
//            if scaleFactor <= 0 {
//                return
//            }
//
//            webView.scrollView.minimumZoomScale = scaleFactor
//            webView.scrollView.maximumZoomScale = 100
//            webView.scalesPageToFit = true
//            webView.scrollView.zoomScale = scaleFactor
//        }
//}

