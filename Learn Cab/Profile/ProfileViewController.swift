//
//  ProfileViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 06/12/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import AFNetworking
import ZRScrollableTabBar
import SDWebImage
import AVFoundation

class ProfileViewController: UIViewController,ZRScrollableTabBarDelegate {
    
    var Tabbar:ZRScrollableTabBar!
    @IBOutlet weak var Tabbarview:UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var professionlab :UILabel!
    @IBOutlet weak var emailLab: UILabel!
    @IBOutlet weak var MobileLab:UILabel!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var editBtn: UIButton!
    var vimage = ""
     var myclass : MyClass!
    var passuserid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem?.image = UIImage(named: "Logo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myclass = MyClass()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        self.title = "PROFILE"
        
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
            professionlab.text = newResult["profession"] as! String
            emailLab.text = newResult["username"] as! String
            MobileLab.text = newResult["mobile_no"] as! String
            name.text = newResult["first_name"] as! String
            vimage = newResult["profile_image"] as! String
            print(vimage)
            if vimage == ""
            {
                imageview.image = UIImage.init(named: "Circle (1).png")
            }
            else
            {
                let newString = vimage.replacingOccurrences(of: " ", with: "%20")
                print(newString)
                imageview.sd_setImage(with: URL(string: newString))
            }
        }
        
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
        Tabbar.selectItem(withTag: 5)
        Tabbar.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: Tabbarview.frame.size.height);
        Tabbarview.addSubview(Tabbar)
        
        // Do any additional setup after loading the view.
        self.datalink()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)

        }
        else if tag == 4
        {
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "QandAViewController") as! QandAViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)

        }
        else if tag == 5
        {
           
            
        }
        
    }
    
    @IBAction func editlick(_ sender: UIButton)
    {
        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        let nav = UINavigationController.init(rootViewController: mainview)
        self.present(nav, animated:true, completion: nil)
    }
    
    func datalink()
    {
        let professionstr : String!
        professionstr = professionlab.text
        UserDefaults.standard.set(professionstr, forKey:"Profession")
        UserDefaults.standard.synchronize()
        
        let emailstr : String!
        emailstr = emailLab.text
        UserDefaults.standard.set(professionstr, forKey:"email")
        UserDefaults.standard.synchronize()
        
        let mobilenostr : String!
        mobilenostr = MobileLab.text
        UserDefaults.standard.set(professionstr, forKey:"mobile_no")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func logoutbutton(_sender : UIButton)
    {
        
        let uiAlert = UIAlertController(title: "LOGOUT", message: "Do you want to Logout?", preferredStyle: UIAlertController.Style.alert)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { action in
            print("Click of default button")
            
            UserDefaults.standard.removeObject(forKey: "Logindetail")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.synchronize()
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let nav = UINavigationController.init(rootViewController: mainview)
            self.present(nav, animated:true, completion: nil)
            
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Click of cancel button")
        }))
        
    }
}
