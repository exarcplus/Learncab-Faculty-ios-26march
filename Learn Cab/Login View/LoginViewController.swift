//
//  LoginViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 30/11/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import JWTDecode
//import ZVProgressHUD
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernametext : SkyFloatingLabelTextField!
    @IBOutlet weak var passwordtext : SkyFloatingLabelTextField!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var forgot: UIButton!
    var myclass : MyClass!
    var passuserid : String!
    var passwordstr : String!
    var users : String!
    var arr = [Dictionary<String,AnyObject>]()
    var array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.navigationBar.isHidden = true;
         myclass = MyClass()
        
        passuserid = self.usernametext.text
        passwordstr = self.passwordtext.text
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        //create toolbar object
//        let doneToolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
//        doneToolBar.barTintColor = UIColor.init(red: 46.0/255.0, green: 104.0/255.0, blue: 180.0/255.0, alpha: 1.0)
//        doneToolBar.isTranslucent = false
//        
//        //add barbuttonitems to toolbar
//        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil) // flexible space to add left end side
//        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "LOGIN", style: .plain, target: self, action: #selector(LoginViewController.didPressDoneButton(_textfield:)))
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//            [
//                //                NSAttributedStringKey.font : UIFont(name: "CenturyGothic-Bold", size: 16)!,
//                //                NSAttributedStringKey.foregroundColor : UIColor.white
//                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),
//                NSAttributedStringKey.foregroundColor : UIColor.white
//            ],
//            for: .normal)
//        doneButton.width = self.view.frame.size.width
//        doneToolBar.items = [flexsibleSpace,doneButton,flexsibleSpace]
//        usernametext.inputAccessoryView = doneToolBar
//        passwordtext.inputAccessoryView = doneToolBar
//        doneToolBar.sizeToFit()
//
        // Do any additional setup after loading the view.
    }
    
    @objc func didPressDoneButton(_textfield : SkyFloatingLabelTextField)
    {
        self.view.endEditing(true)
        if usernametext.text == "" && passwordtext.text == ""
        {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x - 10,y :usernametext.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x + 10,y :usernametext.center.y))
            usernametext.layer.add(animation, forKey: "position")

            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x - 10,y :passwordtext.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x + 10,y :passwordtext.center.y))
            passwordtext.layer.add(animation1, forKey: "position")
        }
        else if usernametext.text == ""
        {
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x - 10,y :usernametext.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x + 10,y :usernametext.center.y))
            usernametext.layer.add(animation1, forKey: "position")
        }
        else if passwordtext.text == ""
        {
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x - 10,y :passwordtext.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x + 10,y :passwordtext.center.y))
            passwordtext.layer.add(animation1, forKey: "position")
        }
        else
        {
            if usernametext.text != ""
            {
                if !validateEmail(usernametext.text!)
                {
                    self.myclass.ShowsinglebutAlertwithTitle(title: "Login", withAlert:"Enter Valid Email ID", withIdentifier:"")
                }
                else
                {
                    self.view.endEditing(true)
                    self.login()
                }
            }
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
    func textFieldDidBeginEditing() {
      
//        if
//        {
//            let point = CGPoint(x: 0, y: 90) // 200 or any value you like.
//            scrollView.setContentOffset(point, animated: true)
//        }
        
    }
//    if p
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let point = CGPoint(x: 0, y: 2) // 200 or any value you like.
//        //scrollView.contentOffset = point
////        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
//        scrollView.setContentOffset(point, animated: true)
//    }
    func validateEmail(_ candidate: String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    @IBAction func loginbuttonclick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if usernametext.text == "" && passwordtext.text == ""
        {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x - 10,y :usernametext.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x + 10,y :usernametext.center.y))
            usernametext.layer.add(animation, forKey: "position")
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x - 10,y :passwordtext.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x + 10,y :passwordtext.center.y))
            passwordtext.layer.add(animation1, forKey: "position")
        }
        else if usernametext.text == ""
        {
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x - 10,y :usernametext.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: usernametext.center.x + 10,y :usernametext.center.y))
            usernametext.layer.add(animation1, forKey: "position")
        }
        else if passwordtext.text == ""
        {
            
            let animation1 = CABasicAnimation(keyPath: "position")
            animation1.duration = 0.07
            animation1.repeatCount = 4
            animation1.autoreverses = true
            animation1.fromValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x - 10,y :passwordtext.center.y))
            animation1.toValue = NSValue(cgPoint: CGPoint(x: passwordtext.center.x + 10,y :passwordtext.center.y))
            passwordtext.layer.add(animation1, forKey: "position")
        }
        else
        {
            if usernametext.text != ""
            {
                if !validateEmail(usernametext.text!)
                {
                    self.myclass.ShowsinglebutAlertwithTitle(title: "Login", withAlert:"Enter Valid Email ID", withIdentifier:"")
                }
                else
                {
                    self.view.endEditing(true)
                    self.login()
                }
            }
        }
    }
   
        
    func login()
    {
        var deviceid : String!
        print(deviceid)
        if UserDefaults.standard.string(forKey: "device_token") == nil
        {
            deviceid = ""
            //devicetoken = newDeviceId
        }
        else
        {
            deviceid = UserDefaults.standard.string(forKey: "device_token") as String?
            //devicetoken = newDeviceId
            print(deviceid)
        }
        
        let params:[String:String] = ["username":usernametext.text!,"password":passwordtext.text!]
//        ZVProgressHUD.maskType = .black
//        ZVProgressHUD.show()
        SVProgressHUD.show()
        Alamofire.request("https:/manage.learncab.com/login_faculty/?", method: .get, parameters: params).responseJSON {
            response in
            //ZVProgressHUD.dismiss()
            print(response)
            print(params)
            
            let result = response.result
            print(response)
            if let dict = result.value as? Dictionary<String,AnyObject>{
                print(dict)
                let res = dict["result"] as? String
                print(res as Any)
                
                 let data = dict["data"] as? [Dictionary<String,AnyObject>]
                print(data)
                if res == "success"
                {
                    if let userData = data![0] as? Dictionary<String,AnyObject>{
                        
                        print(userData)
                         UserDefaults.standard.set(userData, forKey: "Logindetail")
                    }
                    //let dat = NSKeyedArchiver.archivedData(withRootObject: data as! [Dictionary<String,AnyObject>])
                   
                    let token = dict["token"] as? String
                    print(token as Any)
                    UserDefaults.standard.set(token, forKey:"token")
                    UserDefaults.standard.synchronize()
                        let pswstatus = data![0]["password_status"] as? Int
                    print(pswstatus as Any)
                    
                    let userid = data![0]["id"] as? String
                    print(userid)
//                        UserDefaults.standard.set(pswstatus, forKey:"password_status")
//                        UserDefaults.standard.synchronize()
                        let faculty = data![0]["faculty_id"] as? String
                    print(faculty as Any)
                        UserDefaults.standard.set(userid, forKey:"id")
                        UserDefaults.standard.synchronize()
                    
                        if pswstatus == 0
                        {
                            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
//                            mainview.tokenstr = token
//                            mainview.faculty_id = faculty
//                            mainview.passuserid = userid
                            let nav = UINavigationController.init(rootViewController: mainview)
                            self.present(nav, animated:true, completion: nil)
                        }
                        else
                        {
                            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            let nav = UINavigationController.init(rootViewController: mainview)
                             //mainview.tokenstr = token
                             //mainview.passuserid = userid
                            self.present(nav, animated:true, completion: nil)
                        }
                }
                else if res == "blocked"
                {
                    self.usernametext.text = ""
                    self.passwordtext.text = ""
                     self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"You are Blocked" , withIdentifier: "")
                }
                else if res == "check your username"
                {
                    self.view.endEditing(true)
                    self.usernametext.text = ""
                    self.passwordtext.text = ""
                    self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"check your username" , withIdentifier: "")
                }
                else if res == "check your password"
                {
                    //self.view.endEditing(true)
                    self.usernametext.text = ""
                    self.passwordtext.text = ""
                    self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "check your password"), withIdentifier:"")
                    
                   // self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"check your password" , withIdentifier: "Error")
                }
            }
        }
        SVProgressHUD.dismiss()
    }
//                print(dict["success"]) as? String
//                print(dict["token"]) as? String
//
//
//                if(dict["success"] as! Bool == true)
//                {
//
//                    var encodedString = dict["token"] as! String
//                    //                let decodedString = encodedString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//                    //                print(decodedString)
//
//                    let myvalue = getJwtBodyString(tokenstr: encodedString) as String
//                    print(myvalue)
//
//
//                    let dictss = convertToDictionary(text: myvalue) as! NSDictionary
//                    print(dictss)
//                    let userid = dictss["_id"] as! String
//                    print(userid)
//                    UserDefaults.standard.set(userid, forKey:"_id")
//                    UserDefaults.standard.synchronize()
//                    print(UserDefaults.standard.set(userid, forKey:"_id"))
////                    self.arr = [dictss as! [String : AnyObject]]
//                    //self.arr.append(dictss as! [String : AnyObject])
////                    print(self.arr)
//                    let actsts = dictss["activestatus"] as! String
//                    print(actsts)
//                    if actsts == "1"
//                    {
//                        UserDefaults.standard.set(userid, forKey:"_id")
//                        UserDefaults.standard.synchronize()
//                        print("home screen")
//                        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                        let nav = UINavigationController.init(rootViewController: mainview)
//                        self.present(nav, animated:true, completion: nil)
//                    }
//                    else if actsts == "2"
//                    {
//                        print("blocked")
//                        self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"You are Blocked" , withIdentifier: "Error")
//
//                    }
//                    else
//                    {
//                        UserDefaults.standard.set(userid, forKey:"_id")
//                        UserDefaults.standard.synchronize()
//                        print("go to password page")
//                        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
//                        mainview.getdetails = dictss
//                        self.navigationController?.pushViewController(mainview, animated: true)
//                    }
//                }
//                else
//                {
//                    self.myclass.ShowsinglebutAlertwithTitle(title: "oops!", withAlert:"User not found or wrong password " ,
//                                                                 withIdentifier: "Error")
//                }
//            }
//
//            ZVProgressHUD.dismiss()
//
//    }
//             func getJwtBodyString(tokenstr: String) -> NSString {
//
//                var segments = tokenstr.components(separatedBy: ".")
//                var base64String = segments[1]
//                print("\(base64String)")
//                let requiredLength = Int(4 * ceil(Float(base64String.characters.count) / 4.0))
//                let nbrPaddings = requiredLength - base64String.characters.count
//                if nbrPaddings > 0 {
//                    let padding = String().padding(toLength: nbrPaddings, withPad: "=", startingAt: 0)
//                    base64String = base64String.appending(padding)
//                }
//                base64String = base64String.replacingOccurrences(of: "-", with: "+")
//                base64String = base64String.replacingOccurrences(of: "_", with: "/")
//                let decodedData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions(rawValue: UInt(0)))
//                //  var decodedString : String = String(decodedData : nsdata as Data, encoding: String.Encoding.utf8)
//
//                let base64Decoded: String = String(data: decodedData! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//                print("\(base64Decoded)")
////                array = [base64Decoded]
////                print(array)
//                return base64Decoded as NSString
//            }
//
//            func convertToDictionary(text: String) -> [String: Any]? {
//                if let data = text.data(using: .utf8) {
//                    do {
//                        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//                return nil
//            }
//    }
    

    



    @IBAction func forgot(_ sender: Any)
    {
        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "ForgotViewController") as! ForgotViewController
        self.navigationController?.pushViewController(mainview, animated: true)
    }
    
}
