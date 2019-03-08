//
//  PlayerViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 22/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import WebKit
import MTLLinkLabel

class PlayerViewController: UIViewController,UIWebViewDelegate ,LinkLabelDelegate{

    
    var pdfstr : String!
    var lecture_id : String!
    var content : String!
    var titlestr : String!
    @IBOutlet weak var webView : UIWebView!
    @IBOutlet weak var pdflable : LinkLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
         self.navigationItem.title = titlestr
        
        let formattedString = pdfstr.replacingOccurrences(of: " ", with: "%20")
        pdflable.isUserInteractionEnabled = true
        pdflable.delegate = self as! LinkLabelDelegate
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = pdflable.font.pointSize * 1.5
        paragraphStyle.maximumLineHeight = pdflable.font.pointSize * 1.5
        pdflable.attributedText = NSAttributedString(string: formattedString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue,NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.webView.delegate = self
        let font = UIFont.init(name: "Poppins-Light", size: 14)
        webView.scrollView.isScrollEnabled = true
        webView.backgroundColor = .clear
        //self.webview.loadHTMLString("<span style=\"font-family: \(font!.fontName); font-size: \(font!.pointSize); \">\(discription)</span>", baseURL: nil)
        self.webView.loadHTMLString(content, baseURL: nil)
    }
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
