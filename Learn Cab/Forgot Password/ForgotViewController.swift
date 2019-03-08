//
//  ForgotViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 1/3/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
//import ZVProgressHUD
class ForgotViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailid: SkyFloatingLabelTextField!
    var passusername : String!
    var myclass : MyClass!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
         myclass = MyClass()
       passusername = self.emailid.text
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //create toolbar object
        let doneToolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        doneToolBar.barTintColor = UIColor.init(red: 46.0/255.0, green: 104.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        doneToolBar.isTranslucent = false
        
        //add barbuttonitems to toolbar
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil) // flexible space to add left end side
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "SUBMIT", style: .plain, target: self, action: #selector(ForgotViewController.didPressDoneButton(_textfield:)))
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                //                NSAttributedStringKey.font : UIFont(name: "CenturyGothic-Bold", size: 16)!,
                //                NSAttributedStringKey.foregroundColor : UIColor.white
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ],
            for: .normal)
        doneButton.width = self.view.frame.size.width
        doneToolBar.items = [flexsibleSpace,doneButton,flexsibleSpace]
        emailid.inputAccessoryView = doneToolBar
        doneToolBar.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    @objc func didPressDoneButton(_textfield : SkyFloatingLabelTextField)
    {
        print("forgotbuttontouch")
        self.view.endEditing(true)
        let params: [String:String] = ["username": emailid.text!]
        Alamofire.request("https://manage.learncab.com/forgot_password" , method: .post, parameters: params).responseJSON {
            response in
            
            print(response)
            print(params)
            
            let result = response.result
            print(response)
            if let dict = result.value as? Dictionary<String,AnyObject>{
                print(dict["result"]) as? String
                
                let res = dict["result"] as? String
                if res  == "success"
                {
                    let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                    let nav = UINavigationController.init(rootViewController: mainview)
                    self.present(nav, animated:true, completion: nil)
                    
                }
                else{
                    
                    self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"Authentication failed. User not found." ,
                                                             withIdentifier: "Error")
                }
            }
        }
         ZVProgressHUD.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
       self.view.endEditing(true)
        let params: [String:String] = ["username": emailid.text!]
        ZVProgressHUD.maskType = .black
        ZVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/forgot_password" , method: .post, parameters: params).responseJSON {
                response in
                
                print(response)
                print(params)
                
                let result = response.result
                print(response)
                if let dict = result.value as? Dictionary<String,AnyObject>{
                print(dict["result"]) as? String
                let res = dict["result"] as? String
                if res  == "success"
                {
                    self.myclass.ShowsinglebutAlertwithTitle(title: "LearnCab", withAlert:"Please check your Mail.. To Reset The  Password" ,
                                                             withIdentifier: "")
                    let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    let nav = UINavigationController.init(rootViewController: mainview)
                    self.present(nav, animated:true, completion: nil)
                    
                    }
                else{
                    
                    self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"Authentication failed. User not found." ,
                                                             withIdentifier: "Error")
                    }
                }
                ZVProgressHUD.dismiss()
        }
        
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
