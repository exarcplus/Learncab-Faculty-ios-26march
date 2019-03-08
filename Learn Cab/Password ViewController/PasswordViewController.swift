//
//  PasswordViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 26/12/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class PasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var newpassword: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmpassword: SkyFloatingLabelTextField!
    var myclass : MyClass!
    var newpass : String!
    var tokenstr : String!
    var faculty_id : String!
    var confirmpass : String!
    var getdetails : NSDictionary!
    var  passuserid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        myclass = MyClass()
       newpass = self.newpassword.text
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
//        print(tokenstr)
//        print(faculty_id)
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
            
        }
        
        //create toolbar object
        let doneToolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        doneToolBar.barTintColor = UIColor.init(red: 46.0/255.0, green: 104.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        doneToolBar.isTranslucent = false
        
        //add barbuttonitems to toolbar
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil) // flexible space to add left end side
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "SUBMIT", style: .plain, target: self, action: #selector(PasswordViewController.didPressDoneButton(_textfield:)))
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
        newpassword.inputAccessoryView = doneToolBar
        confirmpassword.inputAccessoryView = doneToolBar
        doneToolBar.sizeToFit()

        // Do any additional setup after loading the view.
    }
    
    @objc func didPressDoneButton(_textfield : SkyFloatingLabelTextField)
    {
        print("passwordbuttontouch")
        if newpassword.text == "" && confirmpassword.text == ""
        {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: newpassword.center.x - 10,y :newpassword.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: newpassword.center.x + 10,y :newpassword.center.y))
            newpassword.layer.add(animation, forKey: "position")
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x - 10,y :confirmpassword.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x + 10,y :confirmpassword.center.y))
            confirmpassword.layer.add(animation1, forKey: "position")
        }
            
        else if newpassword.text == ""
        {
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x:newpassword.center.x - 10,y :newpassword.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: newpassword.center.x + 10,y :newpassword.center.y))
            newpassword.layer.add(animation1, forKey: "position")
        }
        else if confirmpassword.text == ""
        {
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x - 10,y :confirmpassword.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x + 10,y :confirmpassword.center.y))
            confirmpassword.layer.add(animation1, forKey: "position")
        }
        else if newpassword.text == confirmpassword.text
        {
            self.login()
        }
        else
        {
            self.myclass.ShowsinglebutAlertwithTitle(title: "Login", withAlert:"Your password and confirm password do not match", withIdentifier:"")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "{8,}")
        return passwordTest.evaluate(with: password)
    }

    @IBAction func loginbuttonclick(_ sender: UIButton)
    {
        if newpassword.text == "" && confirmpassword.text == ""
        {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: newpassword.center.x - 10,y :newpassword.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: newpassword.center.x + 10,y :newpassword.center.y))
            newpassword.layer.add(animation, forKey: "position")
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x - 10,y :confirmpassword.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x + 10,y :confirmpassword.center.y))
            confirmpassword.layer.add(animation1, forKey: "position")
        }
        
        else if newpassword.text == ""
        {
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x:newpassword.center.x - 10,y :newpassword.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: newpassword.center.x + 10,y :newpassword.center.y))
            newpassword.layer.add(animation1, forKey: "position")
        }
        else if confirmpassword.text == ""
        {
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x - 10,y :confirmpassword.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: confirmpassword.center.x + 10,y :confirmpassword.center.y))
            confirmpassword.layer.add(animation1, forKey: "position")
        }
        else if newpassword.text == confirmpassword.text
        {
                self.login()
        }
        else
        {
            self.myclass.ShowsinglebutAlertwithTitle(title: "Login", withAlert:"Your password and confirm password do not match", withIdentifier:"")
        }
    }
    
        func login()
        {
            let params:[String:String] = ["token":tokenstr,"facultyId":passuserid, "password": newpassword.text!]
            SVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/create_password/?", method: .post, parameters: params).responseJSON {
                response in
                
                print(response)
                print(params)
                
                let result = response.result
                print(response)
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print(dict)
                    print(dict["result"]) as? String
                    let res = dict["result"] as? String
                    if res == "success"
                    {
                        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        let nav = UINavigationController.init(rootViewController: mainview)
                         self.present(nav, animated:true, completion: nil)
                    }
            
                    else
                    {
                        self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"User not found or wrong password" ,
                                                                 withIdentifier: "Error")
                    }
                }
                SVProgressHUD.dismiss()
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

    @IBAction func backclick(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }


}



