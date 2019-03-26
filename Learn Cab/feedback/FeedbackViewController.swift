//
//  FeedbackViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 06/12/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import AFNetworking
import ZRScrollableTabBar
import Alamofire
import SVProgressHUD

class FeedbackViewController: UIViewController,ZRScrollableTabBarDelegate {

    var Tabbar:ZRScrollableTabBar!
    @IBOutlet weak var Tabbarview:UIView!
    @IBOutlet weak var Textview:UITextView!
    var tokenstr : String!
    var passuserid : String!
    var mesg : String!
    var myclass : MyClass!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        myclass = MyClass()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        self.title = "FEEDBACK"
       
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
           // self.ongoinglink()
        }
        
        navigationItem.leftBarButtonItem?.image = UIImage(named: "Logo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let item1 = UITabBarItem.init(title:"Studio", image: UIImage.init(named:"studio"), tag: 1)
        item1.image = UIImage.init(named: "studio")?.withRenderingMode(.alwaysOriginal)
        item1.selectedImage = UIImage.init(named: "studioColour")?.withRenderingMode(.alwaysOriginal)
       
        let item2 = UITabBarItem.init(title:"Dashboard", image: UIImage.init(named:"DashBoard"), tag: 2)
        item2.image = UIImage.init(named: "DashBoard")?.withRenderingMode(.alwaysOriginal)
        item2.selectedImage = UIImage.init(named: "DashBoardColour")?.withRenderingMode(.alwaysOriginal)
        let item3 = UITabBarItem.init(title:"Feedback", image: UIImage.init(named:"feedback"), tag: 3)
        item3.image = UIImage.init(named: "feedback")?.withRenderingMode(.alwaysOriginal)
        item3.selectedImage = UIImage.init(named: "feedbackColour")?.withRenderingMode(.alwaysOriginal)
        
        let item4 = UITabBarItem.init(title:"Q&A", image: UIImage.init(named:"qa"), tag: 4)
        item4.image = UIImage.init(named: "qa")?.withRenderingMode(.alwaysOriginal)
        item4.selectedImage = UIImage.init(named: "qacolor")?.withRenderingMode(.alwaysOriginal)
        
        let item5 = UITabBarItem.init(title:"Profile", image: UIImage.init(named:"Profile"), tag: 5)
        item5.image = UIImage.init(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        item5.selectedImage = UIImage.init(named: "ProfileColour")?.withRenderingMode(.alwaysOriginal)
        
        Tabbar = ZRScrollableTabBar.init(items: [item1,item2,item3,item4,item5])
        Tabbar.tintColor = myclass.colorWithHexString(hex: "#000000")
        Tabbar.scrollableTabBarDelegate = self;
        Tabbar.selectItem(withTag: 3)
        Tabbar.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: Tabbarview.frame.size.height);
        Tabbarview.addSubview(Tabbar)
        
        let borderColor = UIColor.black.cgColor
        Textview.layer.borderColor = borderColor.copy(alpha: 0.1)
        Textview.layer.borderWidth = 1.5;
        Textview.layer.cornerRadius = 5.0;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
//        UIApplication.shared.setStatusBarHidden(false, with: .none)
//    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        self.navigationController?.navigationBar.isHidden = false
    }
//
    
    func scrollableTabBar(_ tabBar: ZRScrollableTabBar!, didSelectItemWithTag tag: Int32)
    {
        if tag == 1
        {
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)

        }
        else if tag == 2
        {
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)

        }
        else if tag == 3
        {
           
 
        }
        else if tag == 4
        {
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "QandAViewController") as! QandAViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)
           
        }
        else if tag == 5
        {
           
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)
        }
        
    }
    
    
    func feedbacklink()
    {
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"message":mesg]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/send_feedback", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dat = result.value as? Dictionary<String,AnyObject>
            {
                let res = dat["result"] as! String
                if res == "success"
                {
                    self.Textview.text = ""
                    self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "Thank you for your feedback."), withIdentifier:"Thank you for your feedback.")
//                    let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                    let nav = UINavigationController.init(rootViewController: mainview)
//                    self.present(nav, animated:true, completion: nil)
                }
                
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
             SVProgressHUD.dismiss()
        }
    }
    
    
    @IBAction func submitbutton(_ x:AnyObject)
    {
        mesg = Textview.text!
        print(mesg)
        if mesg == ""
        {
            self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "Please Enter Feedback."), withIdentifier:"Please Enter Feedback.")
        }
        else
        {
            self.feedbacklink()
        }
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
