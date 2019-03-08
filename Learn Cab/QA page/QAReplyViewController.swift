//
//  QAReplyViewController.swift
//  Learn Cab
//
//  Created by Vignesh Waran on 22/02/19.
//  Copyright © 2019 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire


class QAReplyViewController: UIViewController {

    
    @IBOutlet weak var topview: UIView!
     @IBOutlet weak var send_text: UITextField!
     @IBOutlet weak var sname_lbl: UILabel!
     @IBOutlet weak var simage: UIImageView!
    @IBOutlet weak var send_btn: UIButton!
    
     @IBOutlet weak var quation_lbl: UILabel!
     @IBOutlet weak var answer_lbl: UILabel!
     @IBOutlet weak var create_time: UILabel!
     @IBOutlet weak var update_time: UILabel!
    
    
    var qa_id: String!
    var question: String!
    var answer: String!
    var create_timestr: String!
    var update_timestr: String!
    
    var sname: String!
    var simg: String!
    
    var tokenstr: String!
    var passuserid: String!
    var myclass : MyClass!
    
     var alert: JonAlert!
    
    @IBOutlet weak var qview: UIView!
    @IBOutlet weak var aview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
       
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1).cgColor, UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.topview.layer.insertSublayer(gradient, at: 0)

        myclass = MyClass()
        
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
            
        }
        
        self.sname_lbl.text = sname
       
        if simg == ""
        {
            self.simage.image = UIImage.init(named: "Circle (1).png")
        }
        else
        {
            let newString = simg.replacingOccurrences(of: " ", with: "%20")
            print(newString)
            self.simage.sd_setImage(with: URL(string: newString))
        }

        print(question)
        if question == ""
        {
            qview.isHidden = true
        }
        else
        {
             qview.isHidden = false
             quation_lbl.text = question
        }
        
        quation_lbl.text = question
        
        print(create_timestr)
        if create_timestr == ""
        {
            
        }
        else
        {
            var dFormatter = DateFormatter()
            dFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let dtt = dFormatter.date(from: create_timestr);
            print(dtt)
            let chagformater1 = DateFormatter();
            chagformater1.dateFormat = "dd MMM yyyy hh:mma"
            let time = chagformater1.string(from: dtt!)
            print(time)
            create_time.text = time
        }
        
         print(answer)
        if answer == ""
        {
             aview.isHidden = true
        }
        else
        {
            aview.isHidden = false
            
            let str2 = self.answer.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            print(str2)
            let str1 = str2.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
            print(str1)
            
            answer_lbl.text = str1
        }
        
        print(update_timestr)
        if update_timestr == ""
        {
            
        }
        else
        {
            var dFormatter1 = DateFormatter()
            dFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let dtt1 = dFormatter1.date(from: update_timestr);
            print(dtt1)
            let chagformater2 = DateFormatter();
            chagformater2.dateFormat = "dd MMM yyyy hh:mma"
            let time1 = chagformater2.string(from: dtt1!)
            print(time1)
            update_time.text = time1
        }
       
        
        // Do any additional setup after loading the view.
        
        Alert()
    }
    
    private func Alert()
    {
        
        alert = JonAlert()
    }
    
    @IBAction func sendbtn(_sender: UIButton)
    {
        if send_text.text == ""
        {
             self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "Please Enter a Message!."), withIdentifier:"Please Enter a Message!.")
        }
        else{
            
            print(send_text.text!)
            sendlink()
        }
        
    }
    func sendlink()
    {
        
        
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"qa_id":qa_id,"answer":send_text.text!]
        
        ZVProgressHUD.show()
        
        Alamofire.request("https://manage.learncab.com/update_qa_answer", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            if let dat = result.value as? Dictionary<String,AnyObject>
            {
                if dat["result"] as! String == "success"
                {
                    self.send_text.text = ""
                    
                    self.aview.isHidden = false
                     self.answer = dat["answer"] as! String
                    let str2 = self.answer.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    print(str2)
                    let str1 = str2.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                    print(str1)
                    self.answer_lbl.text = str1
                    
                    self.update_timestr = dat["last_updated"] as! String
                    var dFormatter1 = DateFormatter()
                    dFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    let dtt1 = dFormatter1.date(from: self.update_timestr);
                    print(dtt1)
                    let chagformater2 = DateFormatter();
                    chagformater2.dateFormat = "dd MMM yyyy hh:mma"
                    let time1 = chagformater2.string(from: dtt1!)
                    print(time1)
                    self.update_time.text = time1
                    
                    JonAlert.show(message: "Message sent successfully!.",duration: 3)
                }
                
            }
            ZVProgressHUD.dismiss()
            
        }
    }
    
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
  

}
