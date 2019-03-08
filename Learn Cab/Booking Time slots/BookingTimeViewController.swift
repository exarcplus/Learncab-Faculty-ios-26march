//
//  BookingTimeViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 29/01/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class BookingTimeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var listarr = [Dictionary<String,AnyObject>]()
    var list = [Dictionary<String,AnyObject>]()
    var bookingarr = [String]()
    var sponser : ConfirmPopUp!
    @IBOutlet weak var collectionview : UICollectionView!
    @IBOutlet var collectionheight : NSLayoutConstraint!
    var booklistarr = NSMutableArray()
    var bookingIdarr = NSMutableArray()
    var bkTime : String!
   
    var currentTime : String!
    var currentdate : String!
    var course_ID : String!
    var chap_id : String!
    var ids : String!
    var studioname : String!
    var bookingDate : String!
    var chapterName : String!
    var tokenstr : String!
    var passuserid : String!
    var studioID : String!
    var bkTimeSlot : String!
    var myclass : MyClass!
    var collectionindex : Int!
    var bookingScheduleStr : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        myclass = MyClass()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.navigationController?.navigationBar.isHidden = false
        collectionindex = 0
        print(studioname)
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
            
        }
//        passuserid =  UserDefaults.standard.string(forKey: "id")
//        print(passuserid)
        
        let datetime = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        currentdate = dateFormatterGet.string(from: datetime)
        print(currentdate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mma"
        
        currentTime = dateFormatter.string(from: datetime)
        print(currentTime)
        
        print(studioID)
        print(bookingDate)
        self.intiallink()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func intiallink()
    {
       // print(gdate)
        print(tokenstr)
        print(passuserid)
        print(studioID)
        print(bookingDate)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"studio_id":studioID,"date":bookingDate]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/studio_timeslots/", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            if let dat = result.value as? [Dictionary<String,AnyObject>]{
                self.listarr = dat
                print(self.listarr)
                self.collectionview.reloadData()
            }
            SVProgressHUD.dismiss()
        }
    }
   
    //Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  listarr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSlotCollectionViewCell", for: indexPath) as! TimeSlotCollectionViewCell
         self.collectionheight.constant = self.collectionview.contentSize.height
        
        //print(listarr)
        let booking_status = self.listarr[indexPath.item]["booked_status"] as? Int
        print(booking_status)
        if booking_status == 0
        {
            let bookingid = self.listarr[indexPath.item]["timeslot_id"] as? String
            cell.timeLabel.text = self.listarr[indexPath.row]["timeslot"] as! String
            print(bookingIdarr)
            if bookingIdarr.contains(bookingid!)
            {
                cell.timeLabel.backgroundColor = UIColor(red: 110/255, green: 181/255.0, blue: 42/255.0, alpha: 1.0)
                cell.timeLabel.textColor = UIColor.white
            }
            else
            {
                let timing = self.listarr[indexPath.row]["timeslot"] as! String
                let arr = timing.components(separatedBy: "-") as NSArray
                print(arr)
                let fromtt = arr.object(at: 0)
                let tott = arr.object(at: 1)
                let fromtimechange = fromtt
                let fm = fromtt as! String
                print(fm)
                let tm = tott as! String
                print(tm)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mma"
                
                let date = dateFormatter.date(from: fm as! String)
                dateFormatter.dateFormat = "HH:mma"
                
                let fromtimeDate24 = dateFormatter.string(from: date!)
                print("12 hour formatted Date:",fromtimeDate24)
                
                let totimechange = tott
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "hh:mma"
                
                let date2 = dateFormatter2.date(from: tm as! String)
                dateFormatter2.dateFormat = "HH:mma"
                
                let totimeDate24 = dateFormatter2.string(from: date2!)
                print("12 hour formatted Date:",totimeDate24)
                if bookingDate == currentdate
                {
                    print(currentTime)
                    if currentTime > fromtimeDate24
                    {
                        cell.timeLabel.backgroundColor = UIColor(red: 200/255, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
                        cell.timeLabel.textColor = UIColor.white
                    }
                    else
                    {
                        cell.timeLabel.backgroundColor = UIColor.white
                        cell.timeLabel.textColor = UIColor.black
                    }
                }
                else
                {
                    cell.timeLabel.backgroundColor = UIColor.white
                    cell.timeLabel.textColor = UIColor.black
                }
            }
        }
        else if booking_status == 1
        {
           //let bookingid = self.listarr[indexPath.item]["timeslot_id"] as? String
            cell.timeLabel.text = self.listarr[indexPath.row]["timeslot"] as! String
            
                cell.timeLabel.backgroundColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
                cell.timeLabel.textColor = UIColor.white
           // let timing = self.listarr[indexPath.row]["timeslot"] as! String
            let timeid = self.listarr[indexPath.row]["timeslot_id"] as! String
            if bookingIdarr.contains(timeid)
            {
                
            }
            else
            {
//                booklistarr.add(timing)
//                bookingIdarr.add(timeid)
//                print(bookingIdarr)
            }
        }
        else
        {
           // let bookingid = self.listarr[indexPath.item]["timeslot_id"] as? String
            cell.timeLabel.text = self.listarr[indexPath.row]["timeslot"] as! String

                cell.timeLabel.backgroundColor = UIColor(red: 200/255, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
                cell.timeLabel.textColor = UIColor.white
            //let timing = self.listarr[indexPath.row]["timeslot"] as! String
            let timeid = self.listarr[indexPath.row]["timeslot_id"] as! String
            if bookingIdarr.contains(timeid)
            {
//                bookingIdarr.add(timeid)
//                print(bookingIdarr)
            }
            else
            {
//                booklistarr.add(timing)

            }

        }
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
            collectionindex = indexPath.item
        self.collectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.collectionview.reloadData()
            ids = self.listarr[indexPath.row]["timeslot_id"] as! String
            print(ids)
            let bookingstatus = self.listarr[indexPath.row]["booked_status"]  as? Int
            print(bookingstatus)
            if bookingstatus == 0
            {
                if bookingIdarr.contains(ids)
                {
                    let timeid = self.listarr[indexPath.row]["timeslot_id"] as! String
                    print(timeid)
                    let timing = self.listarr[indexPath.row]["timeslot"] as! String
                    print(timing)
                   print(self.booklistarr)
                    print(self.bookingIdarr)
                    self.booklistarr.remove(timing)
                    self.bookingIdarr.remove(timeid)
                    print(self.booklistarr)
                    print(self.bookingIdarr)
                }
                else
                {
               
                    let timing = self.listarr[indexPath.row]["timeslot"] as! String
                    
                    let arr = timing.components(separatedBy: "-") as NSArray
                    print(arr)
                    let fromtt = arr.object(at: 0)
                    let tott = arr.object(at: 1)
                    let fromtimechange = fromtt
                    let fm = fromtt as! String
                    print(fm)
                    let tm = tott as! String
                    print(tm)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mma"
                    
                    let date = dateFormatter.date(from: fm as! String)
                    dateFormatter.dateFormat = "HH:mma"
                    
                    let fromtimeDate24 = dateFormatter.string(from: date!)
                    print("12 hour formatted Date:",fromtimeDate24)
                    
                    let totimechange = tott
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateFormat = "hh:mma"
                    
                    let date2 = dateFormatter2.date(from: tm as! String)
                    dateFormatter2.dateFormat = "HH:mma"
                    
                    let totimeDate24 = dateFormatter2.string(from: date2!)
                    print("12 hour formatted Date:",totimeDate24)

                    if bookingDate == currentdate
                    {
                        print(currentTime)
                        if currentTime > fromtimeDate24
                        {
                           
                        }
                        else
                        {
                            var dic = NSMutableDictionary()
                            dic.setValue(timing, forKey: "timeslot")
                            booklistarr.add(timing)
                            let timeid = self.listarr[indexPath.row]["timeslot_id"] as! String
                            print(timeid)
                            bookingIdarr.add(timeid)
                            print(bookingIdarr)
                            self.bookingarr.append(ids)
                        }
                    }
                    else
                    {
                    
                        var dic = NSMutableDictionary()
                        dic.setValue(timing, forKey: "timeslot")
                        booklistarr.add(timing)
                        let timeid = self.listarr[indexPath.row]["timeslot_id"] as! String
                        print(timeid)
                        bookingIdarr.add(timeid)
                        print(bookingIdarr)
                        self.bookingarr.append(ids)
                    }
                }
            }
            else if bookingstatus == 1
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "Already You Booked"), withIdentifier:"Already You Booked")
            }
            else
            {
//                 self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "Already Some One Booked"), withIdentifier:"Already Some One Booked")
            }
        
            let indexPath = IndexPath(row: indexPath.item, section: indexPath.section)
            self.collectionview.reloadItems(at: [indexPath])
        //        self.Locationlink()
        
    }
    
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Booking Popup
    @IBAction func bookbutton(_sender: UIButton)
    {
        let passtime = self.booklistarr.componentsJoined(by: ",")
        print(passtime)
        let timestr = passtime
        if timestr == ""
        {
            self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "Select Time Slots"), withIdentifier:"Select Time Slots")
        }
        else
        {
            sponser = Bundle.main.loadNibNamed("ConfirmPopUp", owner: self, options: nil)?[0] as! ConfirmPopUp
        //            sponser.layer.zPosition = 2
            sponser.layer.cornerRadius = 5.0
            sponser.layer.masksToBounds = true
            KGModal.sharedInstance().show(withContentView: sponser, andAnimated: true)
            KGModal.sharedInstance().tapOutsideToDismiss = false
            print(booklistarr.count)
        
            sponser.closeButton.addTarget(self, action: #selector(BookingTimeViewController.closebutton(sender:)), for: UIControl.Event.touchUpInside)
            sponser.confirmButton.addTarget(self, action: #selector(BookingTimeViewController.confirmbutton(sender:)), for: UIControl.Event.touchUpInside)
        //sponser.timeslotlab.text = (self.booklistarr.object(at: indexPath.item) as AnyObject).value(forKey: "timings") as! String
        
            let namestr = self.studioname
            if namestr == ""
            {
                sponser.studioName.text = ""
            }
            else
            {
                sponser.studioName.text = String(format: "Studio Name : %@", namestr!)
            }
            let datestr = self.bookingDate
            if datestr == ""
            {
                sponser.datelab.text = ""
            }
            else
            {
                sponser.datelab.text = String(format: "Date : %@", datestr!)
            }
        
            let passtime = self.booklistarr.componentsJoined(by: ",")
            print(passtime)
            let timestr = passtime
            if timestr == ""
            {
                sponser.timeslotlab.text = ""
            }
            else
            {
                sponser.timeslotlab.text = String(format: "Time Slots : %@", timestr)
            }
            let cpstr = self.chapterName
            if cpstr == ""
            {
                sponser.cpName.text = ""
            }
            else
            {
                sponser.cpName.text = String(format: "%@", cpstr!)
            }
        }
    }
    @objc func confirmbutton(sender:UIButton!)
    {
       self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "Booking Successful"), withIdentifier:"Booking Successful")
        KGModal.sharedInstance().hide(animated: true)
        self.confirmllink()
    }
    @objc func closebutton(sender:UIButton!)
    {
       KGModal.sharedInstance().hide(animated: true)
    }
    
    func confirmllink()
    {
        let timeid = self.bookingIdarr.componentsJoined(by: ",")
        print(timeid)
        bkTimeSlot = timeid
        print(bkTimeSlot)
        print(chap_id)
        print(tokenstr)
        print(passuserid)
        print(studioID)
        print(bookingDate)
        print(course_ID)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":course_ID,"studio_id":studioID,"date":bookingDate,"chapter_id":chap_id,"timeslots":bkTimeSlot]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/booking", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                print(dict)
                let res = dict["result"] as? String
                if res == "success"
                {
                    self.bookingScheduleStr = "schedule"
                    let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let nav = UINavigationController.init(rootViewController: mainview)
                    self.present(nav, animated:true, completion: nil)
                }
            }
            SVProgressHUD.dismiss()
        }
    }
}
