//
//  QuizViewController.swift
//  LC Faculty
//
//  Created by Exarcplus on 02/04/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController,UIWebViewDelegate {
    
    var quizstr : String!
    var titlestr : String!
    @IBOutlet weak var webView : UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.navigationItem.title = titlestr
        
         let formattedString = quizstr.replacingOccurrences(of: " ", with: "%20")
        var str = formattedString as! String
        print(str)
       
        let path = Bundle.main.url(forResource: quizstr, withExtension: "html")
        print(path)
        let fileURL:URL = URL(fileURLWithPath: quizstr)
        let req = URLRequest(url: fileURL)
        self.webView.backgroundColor = .clear
        //self.webView.scalesPageToFit = true
//        self.webView.loadHTMLString(req, baseURL: nil)
        self.webView.loadRequest(req)

        
        webView.delegate = self as! UIWebViewDelegate
        webView.scrollView.isScrollEnabled = true
        webView.contentMode = .scaleAspectFit
        webView.backgroundColor = .clear
        webView.scrollView.maximumZoomScale = 2
        webView.scrollView.minimumZoomScale = 1
        webView.scalesPageToFit = true
        //addSubview(webview)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.load(url: quizstr)
    }
    
    func load(url: String) {
        webView.stopLoading()
        if let url = URL(string: quizstr) {
            webView.loadRequest(URLRequest(url: url))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
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
