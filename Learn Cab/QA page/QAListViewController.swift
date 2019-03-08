//
//  QAListViewController.swift
//  Learn Cab
//
//  Created by Vignesh Waran on 25/02/19.
//  Copyright © 2019 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
//import ZVProgressHUD



class QAListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var QATable: UITableView!
     var QAarr = [Dictionary<String,AnyObject>]()
     var QAarr1 = [Dictionary<String,AnyObject>]()
    var chapterid: String!
    var courseid: String!
    @IBOutlet weak var nodata: UILabel!
    var tokenstr: String!
    var passuserid: String!
     var myclass : MyClass!
    var block_status: String!
    var QA_id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        UIApplication.shared.statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        //        let logo = UIImage(named: "facultyname.png")
        //        let imageView = UIImageView(image:logo)
        //        self.navigationItem.titleView = imageView
        //self.navigationController?.navigationBar.isHidden = false
        //navigationItem.leftBarButtonItem?.image = UIImage(named: "Logo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
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
        
        // Do any additional setup after loading the view.
        
        self.nodata.isHidden = true
        self.listlink()
        
    }
    
    func listlink()
    {
        print(courseid)
        print(chapterid)
        if courseid == nil
        {
            self.nodata.isHidden = true
        }
        else
        {
            let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":courseid,"chapter_id":chapterid]
            //let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":"ca_finals","chapter_id":"5ab2368bee23fe240ac9f63d"]
            ZVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/faculty_chapter_questions", method: .post, parameters: params).responseJSON { response in
                
                print(response)
                
                let result = response.result
                print(response)
                // self.publishedemptyview.isHidden = tr
                
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print(dict)
                    self.QAarr.removeAll()
                    if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                        print(dat)
                        self.QAarr = dat
                        
                        
                        //                        self.QAarr.sort {
                        //                                    item1, item2 in
                        //                                    let date1 = item1["created"] as! String
                        //                                    let date2 = item2["created"] as! String
                        //                                    return date1 < date2
                        //                                        }
                        //
                        //                            print(self.QAarr)
                        
                        if self.QAarr.count != 0
                        {
                            self.nodata.isHidden = true
                        }
                        else{
                            self.nodata.isHidden = false
                        }
                        
                       // print(self.QAarr)
                        self.QATable.reloadData()
                        
                        // self.loadfirst()
                    }
                    ZVProgressHUD.dismiss()
                }
                else
                {
                    self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                    ZVProgressHUD.dismiss()
                }
            }
        }
    }
    
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
             return  QAarr.count
           // return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "QATableViewCell", for: indexPath) as! QATableViewCell
        cell.selectionStyle = .none
        
         cell.std_image.backgroundColor = getRandomColor()
         cell.std_name.text = self.QAarr[indexPath.row]["student_name"] as! String
         let simage = self.QAarr[indexPath.row]["student_image"] as! String
        if simage == ""
        {
            cell.std_image.image = UIImage.init(named: "Circle (1).png")
        }
        else
        {
            let newString = simage.replacingOccurrences(of: " ", with: "%20")
            print(newString)
            cell.std_image.sd_setImage(with: URL(string: newString))
        }
         cell.QAlbl.text = self.QAarr[indexPath.row]["question"] as! String
        
        let timestr = self.QAarr[indexPath.row]["created"] as! String
        print(timestr)
        var dFormatter = DateFormatter()
        dFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dtt = dFormatter.date(from: timestr);
        print(dtt)
        let chagformater1 = DateFormatter();
        chagformater1.dateFormat = "dd MMM yyyy hh:mma"
        let time = chagformater1.string(from: dtt!)
        print(time)
        cell.timelbl.text = time
        
        let admin_status = self.QAarr[indexPath.row]["admin_status"] as! String
        print(admin_status)
        if admin_status == "1"
        {
            cell.blockbtn.backgroundColor = UIColor.red
            cell.blockbtn.setTitleColor(.white, for: .normal)
            cell.blockbtn.setTitle("Block", for: .normal)
        }
        else{
            cell.blockbtn.backgroundColor = UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1)
            cell.blockbtn.setTitleColor(.white, for: .normal)
            cell.blockbtn.setTitle("UnBlock", for: .normal)
        }
        
        
        cell.blockbtn.tag = indexPath.row + 123
        cell.blockbtn.addTarget(self, action: #selector(QAListViewController.blockbtnTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        cell.replybtn.tag = indexPath.row + 123
        cell.replybtn.addTarget(self, action: #selector(QAListViewController.reply_btn(sender:)), for: UIControl.Event.touchUpInside)
        return cell;
       
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       // let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "QAReplyViewController") as! QAReplyViewController
       //        self.navigationController?.pushViewController(mainview, animated:true)
        
    }
    
    @objc func reply_btn(sender: UIButton!)
    {
        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "QAReplyViewController") as! QAReplyViewController
        let index = sender.tag-123
        print(index)
        mainview.qa_id = self.QAarr[sender.tag-123]["_id"] as! String
        mainview.question = self.QAarr[sender.tag-123]["question"] as! String
        mainview.answer = self.QAarr[sender.tag-123]["answer"] as! String
        mainview.create_timestr = self.QAarr[sender.tag-123]["created"] as! String
        mainview.update_timestr = self.QAarr[sender.tag-123]["last_updated"] as! String
        mainview.sname = self.QAarr[sender.tag-123]["student_name"] as! String
        mainview.simg = self.QAarr[sender.tag-123]["student_image"] as! String
        self.navigationController?.pushViewController(mainview, animated:true)
        
    }
    
    @objc func blockbtnTapped(sender: UIButton!)
    {
        let index = sender.tag-123
        print(index)
        self.QA_id = self.QAarr[sender.tag-123]["_id"] as! String
        self.block_status = self.QAarr[sender.tag-123]["admin_status"] as! String
        print(self.block_status)
        
        if self.block_status == "1"
        {
            let uiAlert = UIAlertController(title: "LEARNCAB", message: "Do you want to block?.", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
                
                self.block_status = "0"
                self.blocklink()
                
            }))
            
            uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                print("Click of cancel button")
            }))
        }
        else{
            let uiAlert = UIAlertController(title: "LEARNCAB", message: "Do you want to unblock?.", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
                
                self.block_status = "1"
                self.blocklink()
                
            }))
            
            uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                print("Click of cancel button")
            }))
        }
        
        
        //self.blocklink()
    }
    @IBAction func backbtn(_ sender : UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func blocklink()
    {
        print(block_status)
        
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"qa_id":QA_id,"status":block_status]
      
        ZVProgressHUD.show()
        
        Alamofire.request("https://manage.learncab.com/update_qa_status", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            if let dat = result.value as? Dictionary<String,AnyObject>
            {
                if dat["result"] as! String == "success"
                {
                     self.listlink()
                }
               
            }
            ZVProgressHUD.dismiss()
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
