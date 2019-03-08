//
//  BookingCalenderViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 13/12/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
var gdate = ""
class BookingCalenderViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionview : UICollectionView!
    var detailarr = [Dictionary<String,AnyObject>]()
    var passuserid : String!
    var cpname : String!
    var chapter_id : String!
    var tokenstr : String!
    var course_id : String!
    @IBOutlet weak var datepicker: DIDatepicker!
    var myclass : MyClass!

    override func viewDidLoad() {
        super.viewDidLoad()
         myclass = MyClass()
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
        }
        let date = NSDate()
        print(date)
        let day = 24*3600;
        let numda = day*(365*5);
        let chagformater = DateFormatter();
        chagformater.dateFormat = "yyyy-MM-dd"
        let tstr = chagformater.string(from: date as Date)
        let todate = chagformater.date(from: tstr);
        _ = todate!.addingTimeInterval(Double(-numda));
        self.datepicker.fillDates(from: date as Date!, numberOfDays: 30)
        self.datepicker.selectDate(at:0)
       
        
        let dform = DateFormatter()
        dform.dateFormat = "yyyy-MM-dd"
        
        gdate = dform.string(from: datepicker.selectedDate)
        print(gdate)
        
        self.datepicker.addTarget(self, action: #selector(BookingCalenderViewController.getdata), for: .valueChanged)
        self.datepicker.selectedDateBottomLineColor = UIColor(red: 79/255.0, green: 199/255.0, blue: 99/255.0, alpha: 1.0)
        
        //
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateee = Date()
        let dateString = dateFormatter.string(from: dateee)
        print(dateString)
      
        self.intiallink()
    }
    
    @objc func getdata()
    {
       
        let dform = DateFormatter()
        dform.dateFormat = "yyyy-MM-dd"
        gdate = dform.string(from: datepicker.selectedDate)
        print(gdate)
        self.intiallink()
    }
    


    func intiallink()
    {
        print(gdate)
        let params:[String:String] = ["token":tokenstr]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/studio_list/", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? [Dictionary<String,AnyObject>]{
                self.detailarr = dict
                    print(self.detailarr)
                   
                    self.collectionview.reloadData()
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  detailarr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCollectionViewCell", for: indexPath) as! BookingCollectionViewCell
        
        cell.name.text = self.detailarr[indexPath.row]["studio_name"] as! String
        
//        if indexPath.item == collectionindex
//        {
//            cell.roundlabel.backgroundColor = UIColor(red: 49/255, green: 79/255.0, blue: 169/255.0, alpha: 1.0)
//            cell.name.textColor = UIColor.white
//        }
//        else
//        {
//            cell.roundlabel.backgroundColor = UIColor.white
//            cell.name.textColor = UIColor.black
//        }
        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
//
        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "BookingTimeViewController") as! BookingTimeViewController
        //let nav = UINavigationController.init(rootViewController: mainview)
       // mainview.listarr = self.detailarr
        mainview.course_ID = course_id
        mainview.bookingDate = gdate
        mainview.chapterName = cpname
        mainview.chap_id = chapter_id
        mainview.studioID = self.detailarr[indexPath.row]["studio_id"] as! String
        mainview.studioname = self.detailarr[indexPath.row]["studio_name"] as! String
        self.navigationController?.pushViewController(mainview, animated:true)
//        collectionindex = indexPath.item
//        //
//
//        self.collectionview.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
//        self.collectionview.reloadData()
//        courseid = self.detailarr[indexPath.row]["courseid"] as! String
//        print(courseid)
//        self.Locationlink()
        
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
