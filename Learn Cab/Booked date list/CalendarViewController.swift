//
//  CalendarViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 20/02/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CalendarViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var collectionview : UICollectionView!
     @IBOutlet weak var  datelab : UILabel!
    @IBOutlet weak var emtyview : UIView!
    var datearr = [Date]()
    var detailarr = [Dictionary<String,AnyObject>]()
    var passuserid : String!
    var cpname : String!
    var chapter_id : String!
    var tokenstr : String!
    var sdate = ""
    var bookDate = [Date]()
     var listarr = [Dictionary<String,AnyObject>]()
    var course_id : String!
    var selected_Date = [String]()
    var daat : String!
     var myclass : MyClass!
    var slotDate = [Date]()
    var celldic = NSMutableDictionary()
     var bookslot = NSMutableArray()
    var collectionindex : Int!
     @IBOutlet weak var tablelistview : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         myclass = MyClass()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        collectionindex = 0
        let date = NSDate()
        print(date)
        let day = 24*3600;
        let numda = day*(365*5);
        let chagformater = DateFormatter();
        chagformater.dateFormat = "yyyy-MM-dd"
        let tstr = chagformater.string(from: date as Date)
        let todate = chagformater.date(from: tstr);
        
        
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
        }
        celldic.setValue("1", forKey: "status")
        self.ongoinglink()
       
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return datearr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        //self.collectionheight.constant = self.collectionview.contentSize.height
       
        
        let dt = datearr[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let dtstr = formatter.string(from: dt)
        print(dtstr)
        cell.datelab.text = dtstr
        
        let dtformatter = DateFormatter()
        dtformatter.dateFormat = "EEE"
        let daystr = dtformatter.string(from: dt)
        print(daystr)
        cell.dayLab.text = daystr
        
        let mtformatter = DateFormatter()
        mtformatter.dateFormat = "MMM"
        let monthstr = mtformatter.string(from: dt)
        print(monthstr)
        cell.monthlab.text = monthstr
        
        let datestring = datearr[indexPath.row]
        print(datestring)
        
        var dFormatter = DateFormatter()
        dFormatter.dateFormat = "yyyy-MM-dd"
        dFormatter.locale = Locale(identifier: "en_US_POSIX")
        dFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let tstr = dFormatter.string(from: datestring)
        let tdate = dFormatter.date(from: tstr)
        print(tdate)
        print(bookDate)
        if bookDate.contains(tdate!)
        {
            cell.datelab.backgroundColor = UIColor(red: 110/255, green: 181/255.0, blue: 42/255.0, alpha: 1.0)
            cell.datelab.textColor = UIColor.white
            cell.monthlab.font = UIFont.boldSystemFont(ofSize: 12.0)
            cell.dayLab.font = UIFont.boldSystemFont(ofSize: 12.0)
            cell.monthlab.textColor = UIColor(red: 110/255, green: 181/255.0, blue: 42/255.0, alpha: 1.0)
            cell.dayLab.textColor = UIColor(red: 110/255, green: 181/255.0, blue: 42/255.0, alpha: 1.0)
        }
        else
        {
            cell.datelab.backgroundColor = UIColor.white
            cell.datelab.textColor = UIColor.black
            cell.dayLab.font = UIFont.systemFont(ofSize: 12.0)
            cell.monthlab.font = UIFont.systemFont(ofSize: 12.0)
            cell.monthlab.textColor = UIColor(red: 200/255, green:200/255.0, blue: 200/255.0, alpha: 1.0)
            cell.dayLab.textColor = UIColor(red: 0/255, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
        }
        if indexPath.item == collectionindex
        {
            cell.datelab.backgroundColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
            cell.datelab.textColor = UIColor.white
            cell.underlinelab.isHidden = false
        }
        else
        {
            cell.underlinelab.isHidden = true
        }
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionindex = indexPath.item
        self.collectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        self.collectionview.reloadData()
        let datestring = datearr[indexPath.row]
        print(datestring)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let tstr = dateFormatter.string(from: datestring)
        print(tstr)
        let todate = dateFormatter.date(from: tstr)
        print(todate)
      
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "dd-MMM-yyyy"
        let dtstr = dtFormatter.string(from: todate!)
        datelab.text = dtstr
        sdate = tstr
        print(sdate)
        self.intiallink()
    }
    
    func ongoinglink()
    {
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":course_id,"chapter_id":chapter_id]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/booking_list_for_course_id", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dat = result.value as? [Dictionary<String,AnyObject>]
            {
                self.detailarr = dat
                print(self.detailarr)
                for i in 0 ..< self.detailarr.count
                {
                    let bookedt = self.detailarr[i]["booked_date"] as! String
                    let date = NSDate()
                    print(date)
                    var dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    let todate = dateFormatter.date(from: bookedt)
                    print(todate)
                    self.bookDate.append(todate!)
                    let dateString = dateFormatter.string(from: date as Date)
                    self.sdate = dateString
                    let dtFormatter = DateFormatter()
                    dtFormatter.dateFormat = "dd-MMM-yyyy"
                    let dtstr = dtFormatter.string(from: date as Date)
                    self.datelab.text = dtstr
                }
                for day in 0...30 {
                    self.datearr.append(Date(timeIntervalSinceNow: Double(day * 86400)))
                    print(self.datearr)
                }
                self.collectionview.reloadData()
                self.intiallink()
                SVProgressHUD.dismiss()
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    
    func intiallink()
    {
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":course_id,"chapter_id":chapter_id,"date":sdate]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/booking_list_for_chapter_id", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            if let dict = result.value as? [Dictionary<String,AnyObject>]{
                        self.listarr = dict
                print(self.listarr)
                if self.listarr.count == 0
                {
                    self.emtyview.isHidden = false
                }
                else
                {
                    self.emtyview.isHidden = true
                    self.tablelistview.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.listarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookigDateListTableViewCell", for: indexPath) as! BookigDateListTableViewCell
        cell.selectionStyle = .none
        let namestr = self.listarr[indexPath.row]["studio_name"] as! String
        if namestr == ""
        {
            cell.name.text = ""
        }
        else
        {
            cell.name.text = String(format: "Studio Name : %@", namestr)
        }
        if let dict = self.listarr[indexPath.row]["timeslots"] as? [Dictionary<String,AnyObject>]
        {
            print(dict)
            bookslot.removeAllObjects()
             for i in 0 ..< dict.count{
                let dt = dict[i]["timeslot"] as! String
                bookslot.add(dt)
                print(bookslot)
            }
            let passtime = bookslot.componentsJoined(by: ", ")
            print(passtime)
            let timestr = passtime
            if timestr == ""
            {
                cell.name.text = ""
            }
            else
            {
                cell.timelabel.text = String(format: "Timing : %@", timestr)
            }
        }
        
        return cell
    }
    
}
