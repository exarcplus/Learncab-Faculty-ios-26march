//
//  BookingDateViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 15/02/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import FSCalendar
//
class BookingDateViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FSCalendarDelegate,FSCalendarDataSource {
  
    @IBOutlet weak var tablelistview : UITableView!
    @IBOutlet weak var  datelab : UILabel!
    @IBOutlet weak var emtyview : UIView!
    var detailarr = [Dictionary<String,AnyObject>]()
    var passuserid : String!
    var cpname : String!
    var chapter_id : String!
    var tokenstr : String!
    var sdate = ""
    //var passuserid : String!
    var course_id : String!
    var selected_Date = [String]()
    var daat : String!
    @IBOutlet weak var setCalender: FSCalendar!
    var myclass : MyClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
        }

        setCalender.allowsMultipleSelection = true
        setCalender.delegate = self
        setCalender.dataSource = self

        emtyview.isHidden = true
        self.ongoinglink()
    }

    
    
    func intiallink()
    {
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":course_id,"chapter_id":chapter_id,"date":sdate]
        Alamofire.request("https://manage.learncab.com/booking_list_for_chapter_id", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? [Dictionary<String,AnyObject>]{
                
                //                if let dat = dict as? [Dictionary<String,AnyObject>]  {
                //                    print(dat)
                
                
                self.detailarr = dict
                print(self.detailarr)
               if self.detailarr.count == 0
               {
                    self.emtyview.isHidden = false
                }
                else
               {
                self.emtyview.isHidden = true
                    self.tablelistview.reloadData()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return self.detailarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookigDateListTableViewCell", for: indexPath) as! BookigDateListTableViewCell
            cell.selectionStyle = .none
            let namestr = self.detailarr[indexPath.row]["studio_name"] as! String
            if namestr == ""
            {
                cell.name.text = ""
            }
            else
            {
                cell.name.text = String(format: "Studio Name : %@", namestr)
            }
            if let dict = self.detailarr[indexPath.row]["timeslots"] as? [Dictionary<String,AnyObject>]
            {
                let dt = dict[0]["timeslot"] as! String
                if dt == ""
                {
                    cell.name.text = ""
                }
                else
                {
                    cell.timelabel.text = String(format: "Timing : %@", dt)
                }
            }
       
        return cell
    }
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func ongoinglink()
    {
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":course_id,"chapter_id":chapter_id]
        // SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/booking_list_for_course_id", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            let dat = result.value as! [Dictionary<String,AnyObject>]
            print(dat)
            for i in 0 ..< dat.count
            {
                let dt = dat[i]["booked_date"] as! String
                //self.newarr.append(self.datesss)
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let todate = dateFormatter.date(from: dt)
                print(todate)
                let dateString = dateFormatter.string(from: todate!)
                self.sdate = dateString
                //self.setCalender.deselect(todate!)
                self.setCalender.select(todate)
                let dtFormatter = DateFormatter()
                dtFormatter.dateFormat = "dd EEE MMMM"
                let dtstr = dtFormatter.string(from: todate!)
                self.datelab.text = dtstr
            }
            self.intiallink()
        }
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(date))")
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        self.setCalender.select(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "dd EEE MMMM"
        let dtstr = dtFormatter.string(from: date)
        datelab.text = dtstr
        sdate = dateString
        print(sdate)
        self.intiallink()
    }
    
}



