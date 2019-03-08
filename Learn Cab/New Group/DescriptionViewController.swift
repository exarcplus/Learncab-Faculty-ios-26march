//
//  DescriptionViewController.swift
//  LC Faculty
//
//  Created by Exarcplus on 03/04/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController,UIWebViewDelegate {

    var content : String!
    var titlestr : String!
     @IBOutlet weak var webview : UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.navigationItem.title = titlestr
        
        self.webview.delegate = self
        let font = UIFont.init(name: "Poppins-Light", size: 14)
        webview.scrollView.isScrollEnabled = true
        webview.backgroundColor = .clear
        self.webview.loadHTMLString(content, baseURL: nil)
        // Do any additional setup after loading the view.
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
