//
//  HomeViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 30/11/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import AFNetworking
import ZRScrollableTabBar
import SDWebImage
import AVFoundation
import EHHorizontalSelectionView
import Alamofire
import SVProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,ZRScrollableTabBarDelegate,EHHorizontalSelectionViewProtocol,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var newtableview : UITableView!
    @IBOutlet weak var ongoingtableview : UITableView!
    @IBOutlet weak var completedtableview : UITableView!
    @IBOutlet weak var publishedtableview : UITableView!
    @IBOutlet weak var collectionview : UICollectionView!
    @IBOutlet weak var scheduledCollectionview : UICollectionView!
    @IBOutlet weak var playlistCollectionview : UICollectionView!
    @IBOutlet weak var publishedtCollectionview : UICollectionView!
    
    @IBOutlet weak var topview: EHHorizontalSelectionView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var thirdview: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var playlistemptyview: UIView!
    @IBOutlet weak var publishedemptyview: UIView!
    @IBOutlet weak var scheduledemptyview: UIView!
    @IBOutlet weak var firstemptyview: UIView!
    var detailarr = [Dictionary<String,AnyObject>]()
    var listarr = [Dictionary<String,AnyObject>]()
    var Userdic : NSMutableDictionary!
    var segmentarr = [String]()
    var passuserid : String!
    var courseid : String!
    var locationarr = NSMutableArray()
    var palylistCourseArr = [Dictionary<String,AnyObject>]()
    var publishCourseArr = [Dictionary<String,AnyObject>]()
    var dataarr = [Dictionary<String,AnyObject>]()
    var detailsarr = [Dictionary<String,AnyObject>]()
    var publisharr = [Dictionary<String,AnyObject>]()
    var scheduledarr = [Dictionary<String,AnyObject>]()
    var Tabbar:ZRScrollableTabBar!
    var tokenstr : String!
    var collectionindex : Int!
    var collectionindex1 : Int!
    var collectionindex2 : Int!
    var collectionindex3 : Int!
    
    var bookingstr : String!
    var approvestr : String!
    var sendstr : String!
    var reschedulestr : String!
    var status : String!
    var chap_id : String!
    var playlistStatus : String!
    var lecture_id : String!
    
    var datesss : String!
    var collection : String!
    @IBOutlet weak var Tabbarview:UIView!
    var  newarr = [String]()
    var myclass : MyClass!
    
    @IBOutlet weak var count_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myclass = MyClass()
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        UIApplication.shared.statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
//        let logo = UIImage(named: "facultyname.png")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem?.image = UIImage(named: "Logo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
       // self.navigationItem.setLeftBarButtonItems(item1, animated: true)
        reschedulestr = ""
        approvestr = ""
        sendstr = ""
        playlistStatus = ""
        collection = "first"
        segmentarr = ["BOOKING","SCHEDULED","PLAYLIST","PUBLISHED"]
        topview.delegate = self as! EHHorizontalSelectionViewProtocol
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
//        }
        collectionindex = 0
        collectionindex1 = 0
        collectionindex2 = 0
        collectionindex3 = 0
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
        
//        let item5 = UITabBarItem.init(title:"Q&A", image: UIImage.init(named:"qa"), tag: 5)
//        item5.image = UIImage.init(named: "qa")?.withRenderingMode(.alwaysOriginal)
//        item5.selectedImage = UIImage.init(named: "qacolor")?.withRenderingMode(.alwaysOriginal)
        
        Tabbar = ZRScrollableTabBar.init(items: [item1,item2,item3,item4,item5])
        Tabbar.tintColor = myclass.colorWithHexString(hex: "#000000")
        Tabbar.scrollableTabBarDelegate = self;
        Tabbar.selectItem(withTag: 1)
        Tabbar.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: Tabbarview.frame.size.height);
        Tabbarview.addSubview(Tabbar)
        
        self.firstemptyview.isHidden = true
        self.playlistemptyview.isHidden = true
        self.publishedemptyview.isHidden = true
        self.scheduledemptyview.isHidden = true
        
       // self.count_lbl.isHidden = true
        
        //self.Locationlink()
        //self.emptyview.isHidden = true
        self.intiallink()
       
      
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func scrollableTabBar(_ tabBar: ZRScrollableTabBar!, didSelectItemWithTag tag: Int32)
    {
        if tag == 1
        {
            
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
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)
           
        }
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func Locationlink()
    {
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":courseid]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/faculty_chapters", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                    print(dat)
                    
                    self.listarr = dat
                    print(self.listarr)
                    
                    self.secondview.isHidden = true
                    self.thirdview.isHidden = true
                    self.fourthView.isHidden = true
                    self.playlistemptyview.isHidden = true
                    self.publishedemptyview.isHidden = true
                    self.scheduledemptyview.isHidden = true
                    
                    self.newtableview.reloadData()
                    
                    // self.loadfirst()
                }
                SVProgressHUD.dismiss()
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
            
        }
    }
    func ongoinglink()
    {
        print(courseid)
        if courseid == nil
        {
           self.scheduledemptyview.isHidden = false
        }
        else
        {
            let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":courseid]
            SVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/booking_list_for_course_id1", method: .post, parameters: params).responseJSON { response in
            
                print(response)
            
                let result = response.result
                print(response)
            
                if let dat = result.value as? [Dictionary<String,AnyObject>]{
                    self.dataarr =  dat
                    self.scheduledemptyview.isHidden = false
                    print(self.dataarr)
                    for i in 0 ..< self.dataarr.count
                    {
                        self.scheduledemptyview.isHidden = true
                        self.datesss = self.dataarr[i]["booked_date"] as! String
                        self.newarr.append(self.datesss)
                    }
                    self.ongoingtableview.reloadData()
                    SVProgressHUD.dismiss()
                }
                else
                {
                    self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func completelink()
    {
        if courseid == nil
        {
            self.playlistemptyview.isHidden = false
        }
        else
        {
            let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":courseid]
            SVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/faculty_playlist_chapters", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            // self.playlistemptyview.isHidden = false
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                print(dict)
                self.detailsarr.removeAll()
                if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                    print(dat)
                    
                    for i in 0 ..< dat.count
                    {
                         let status = dat[i]["admin_status"] as! String
                        if status == "1"
                        {
                             self.playlistemptyview.isHidden = false
                        }
                        else if status == "0"
                        {
                            print(dat[i])
                            self.detailsarr.append(dat[i])
                            self.playlistemptyview.isHidden = true
                        }
                        else if status == "2"
                        {
                            self.playlistemptyview.isHidden = false
                        }
                        print(self.detailsarr)
                    }

                    self.completedtableview.reloadData()

//                     self.loadfirst()
                }
                SVProgressHUD.dismiss()
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
            }
            
        }
    }
    
    
    func publishlink()
    {
        if courseid == nil
        {
            self.publishedemptyview.isHidden = false
        }
        else
        {
            let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":courseid]
            SVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/faculty_playlist_chapters", method: .post, parameters: params).responseJSON { response in
            
                print(response)
            
                let result = response.result
                print(response)
            // self.publishedemptyview.isHidden = tr
          
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print(dict)
                    self.publisharr.removeAll()
                    if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                        print(dat)
                        for i in 0 ..< dat.count
                        {
                            let status = dat[i]["admin_status"] as! String
                            if status == "1"
                            {
                                print(dat[i])
                                self.publisharr.append(dat[i])
                                //self.publishedemptyview.isHidden = true
                            }
                            else
                            {
                               // self.publishedemptyview.isHidden = false
                            }
                            print(self.publisharr)
                            
                        }
                        if self.publisharr.count != 0
                        {
                            self.publishedemptyview.isHidden = true
                        }
                        else{
                            self.publishedemptyview.isHidden = false
                        }

                        self.publishedtableview.reloadData()

                    // self.loadfirst()
                    }
                    SVProgressHUD.dismiss()
                }
                else
                {
                    self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    
    // MARK: - Tabelview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == newtableview
        {
            return self.listarr.count
        }
        else if tableView == ongoingtableview
        {
            return self.dataarr.count
        }
        else if tableView == completedtableview
        {
            return self.detailsarr.count
        }
        else
        {
            return self.publisharr.count
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    //    {
    //        return 120
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == newtableview
        {
            //let cell:HomeNewTableViewCell=tableView.dequeueReusableCell(withIdentifier: "HomeNewTableViewCell") as! HomeNewTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewListTableViewCell", for: indexPath) as! NewListTableViewCell
            cell.selectionStyle = .none
            
            cell.eventlab.text = self.listarr[indexPath.row]["chapter"] as! String
            cell.descriptionlab.text = self.listarr[indexPath.row]["paper"] as! String
            
            return cell
        }
        else if tableView == ongoingtableview
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnGoingListTableViewCell", for: indexPath) as! OnGoingListTableViewCell
            cell.selectionStyle = .none
           
            cell.eventlab.text = self.dataarr[indexPath.row]["chapter_name"] as! String
            cell.descriptionlab.text = self.dataarr[indexPath.row]["chapter_paper"] as! String
            let userData = self.dataarr[indexPath.row]["timeslots"] as! Int
                print(userData)
            let tm = (userData) * 2
            print(tm)
            let namestr = String(tm)
            if namestr == ""
            {
                cell.timelab.text = ""
            }
            else
            {
                cell.timelab.text = String(format: "%@ hrs", namestr)
            }
            return cell
        }
        else  if tableView == completedtableview
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTableViewCell", for: indexPath) as! CompletedTableViewCell
            cell.selectionStyle = .none
           
            let statustr = self.detailsarr[indexPath.row]["playlist_status"] as? String
//            if statustr == "0"
//            {
                
                cell.eventlab.text = self.detailsarr[indexPath.row]["paper"] as! String
                cell.descriptionlab.text = self.detailsarr[indexPath.row]["chapter"] as! String
                let chapterid = self.detailsarr[indexPath.row]["chapter_id"] as! String
                print(chapterid)
                chap_id = chapterid
                lecture_id = self.detailsarr[indexPath.row]["lecture_id"] as! String
                let adminstatus =  self.detailsarr[indexPath.row]["admin_status"] as! String
                if adminstatus == "0"
                {
                    cell.approvelab.isHidden = false
                    cell.approvebtn.isHidden = false
                    cell.approveimg.isHidden = false
                    cell.reschdulelab.isHidden = false
                    cell.reschdulebtn.isHidden = false
                    cell.reschduleimg.isHidden = false
                    cell.reschduleimg.image = UIImage.init(named: "Circle (1).png")
                    cell.approveimg.image = UIImage.init(named: "Circle (1).png")
                }
                else if adminstatus == "2"
                {
                    cell.approvelab.isHidden = true
                    cell.approvebtn.isHidden = true
                    cell.approveimg.isHidden = true
                    cell.reschduleimg.image = UIImage.init(named: "rtick.png")
                }
            
                let playlist_status = self.detailsarr[indexPath.row]["playlist_status"] as! String
                print(playlist_status)
                if playlist_status == "0"
                {
                    cell.reschduleimg.image = UIImage.init(named: "Circle (1).png")
                    cell.approveimg.image = UIImage.init(named: "Circle (1).png")
                    if reschedulestr == ""
                    {
                        cell.reschduleimg.image = UIImage.init(named: "Circle (1).png")
                    }
                    else
                    {
                        reschedulestr = ""
                        status = "2"
                        cell.reschduleimg.image = UIImage.init(named: "rtick.png")
                        cell.approvelab.isHidden = true
                        cell.approvebtn.isHidden = true
                        cell.approveimg.isHidden = true
                        cell.reschdulelab.isHidden = false
                        cell.reschdulebtn.isHidden = false
                        cell.reschduleimg.isHidden = false
                        //cell.approveimg.image = UIImage.init(named: "Circle (1).png")
                    }
                    if approvestr == ""
                    {
                        cell.approveimg.image = UIImage.init(named: "Circle (1).png")
                    }
                    else
                    {
                        approvestr = ""
                        status = "1"
                        cell.approveimg.image = UIImage.init(named: "rtick.png")
                        cell.reschdulelab.isHidden = true
                        cell.reschdulebtn.isHidden = true
                        cell.reschduleimg.isHidden = true
                        cell.approvelab.isHidden = false
                        cell.approvebtn.isHidden = false
                        cell.approveimg.isHidden = false
                        //cell.reschduleimg.image = UIImage.init(named: "Circle (1).png")
                    }
                }
                else if playlist_status == "1"
                {
                    cell.approveimg.image = UIImage.init(named: "rtick.png")
                    cell.reschdulelab.isHidden = true
                    cell.reschdulebtn.isHidden = true
                    cell.reschduleimg.isHidden = true
                    
                    cell.approvelab.isHidden = false
                    cell.approvebtn.isHidden = false
                    cell.approveimg.isHidden = false
//                    if playlistStatus == ""
//                    {
//
//                        cell.approveimg.image = UIImage.init(named: "rtick.png")
//                    }
//                    else if playlistStatus == "1"
//                    {
//                        cell.approveimg.image = UIImage.init(named: "Circle (1).png")
//                    }
                }
                else if playlist_status == "2"
                {
                    cell.reschduleimg.image = UIImage.init(named: "rtick.png")
                    cell.approvelab.isHidden = true
                    cell.approvebtn.isHidden = true
                    cell.approveimg.isHidden = true
                    
                    cell.reschdulelab.isHidden = false
                    cell.reschdulebtn.isHidden = false
                    cell.reschduleimg.isHidden = false
//                    if playlistStatus == ""
//                    {
//                            cell.reschduleimg.image = UIImage.init(named: "rtick.png")
//                    }
//                    else if playlistStatus == "2"
//                    {
//                        cell.reschduleimg.image = UIImage.init(named: "Circle (1).png")
//                    }
                }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            
            //extra
            if playlist_status == "1"
            {
                cell.reschdulelab.isHidden = true
                cell.reschdulebtn.isHidden = true
                cell.reschduleimg.isHidden = true
                cell.approvebtn.tag = indexPath.row + 123
                cell.approvebtn.addTarget(self, action: #selector(HomeViewController.approvebtn(sender:)), for: UIControl.Event.touchUpInside)
            }
            else if playlist_status == "2"
            {
                cell.approvelab.isHidden = true
                cell.approvebtn.isHidden = true
                cell.approveimg.isHidden = true
                cell.reschdulebtn.tag = indexPath.row + 123
                cell.reschdulebtn.addTarget(self, action: #selector(HomeViewController.reschdulebtn(sender:)), for: UIControl.Event.touchUpInside)
            }
            else
            {
                
                cell.approvelab.isHidden = false
                cell.approvebtn.isHidden = false
                cell.approveimg.isHidden = false
                cell.reschdulelab.isHidden = false
                cell.reschdulebtn.isHidden = false
                cell.reschduleimg.isHidden = false
                cell.reschdulebtn.tag = indexPath.row + 123
                cell.reschdulebtn.addTarget(self, action: #selector(HomeViewController.reschdulebtn(sender:)), for: UIControl.Event.touchUpInside)
            
                cell.approvebtn.tag = indexPath.row + 123
                cell.approvebtn.addTarget(self, action: #selector(HomeViewController.approvebtn(sender:)), for: UIControl.Event.touchUpInside)
            }
             return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTableViewCell", for: indexPath) as! CompletedTableViewCell
                cell.selectionStyle = .none
                    cell.eventlab.text = self.publisharr[indexPath.row]["paper"] as! String
                    cell.descriptionlab.text = self.publisharr[indexPath.row]["chapter"] as! String
                    let chapterid = self.publisharr[indexPath.row]["chapter_id"] as! String
                    print(chapterid)
                    chap_id = chapterid
                    lecture_id = self.publisharr[indexPath.row]["lecture_id"] as! String
                    
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == newtableview
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "BookingCalenderViewController") as! BookingCalenderViewController
            print(courseid)
            mainview.course_id = courseid
            mainview.cpname = self.listarr[indexPath.row]["chapter"] as! String
            mainview.chapter_id = self.listarr[indexPath.row]["chapter_id"] as! String
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else if tableView == ongoingtableview
        {
             let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
                mainview.course_id = courseid
                mainview.cpname = self.dataarr[indexPath.row]["chapter_name"] as! String
                mainview.chapter_id = self.dataarr[indexPath.row]["chapter_id"] as! String
                mainview.selected_Date = self.newarr
            print(newarr)
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else if tableView == completedtableview
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlayNameViewController") as! PlayNameViewController
            mainview.LC_id = self.detailsarr[indexPath.row]["lecture_id"] as! String
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlayNameViewController") as! PlayNameViewController
            mainview.LC_id = self.publisharr[indexPath.row]["lecture_id"] as! String
            mainview.description_str = self.publisharr[indexPath.row]["description"] as! String
            self.navigationController?.pushViewController(mainview, animated:true)
        }
    }
    
    
    func numberOfItems(inHorizontalSelection hSelView: EHHorizontalSelectionView) -> UInt {
        if (hSelView == topview)
        {
            return UInt(segmentarr.count)
        }
        return 0;
    }
    
    func titleForItem(at index: UInt, forHorisontalSelection hSelView: EHHorizontalSelectionView) -> String? {
        return segmentarr[Int(index)]
    }
    func titleForItem(at index: UInt, forHorisontalSelectionHeight hSelView: EHHorizontalSelectionView) -> CGFloat
    {
        return 40;
    }
        
    func horizontalSelection(_ hSelView: EHHorizontalSelectionView, didSelectObjectAt index: UInt) {

        if index == 0
        {
            collection = "first"
            title = segmentarr[Int(index)]
            firstView.isHidden = false
            secondview.isHidden = true
            thirdview.isHidden = true
            fourthView.isHidden = true
            self.firstemptyview.isHidden = true
            self.playlistemptyview.isHidden = true
            self.publishedemptyview.isHidden = true
            self.scheduledemptyview.isHidden = true
            fourthView.isHidden = true
            self.intiallink()
            
            // self.count_lbl.isHidden = true
        }
        else if index == 1
        {
            collection = "second"
             title = segmentarr[Int(index)]
            firstView.isHidden = true
            secondview.isHidden = false
            thirdview.isHidden = true
            fourthView.isHidden = true
            self.firstemptyview.isHidden = true
            self.playlistemptyview.isHidden = true
            self.publishedemptyview.isHidden = true
            self.scheduledemptyview.isHidden = true
            self.intiallink()
            
            // self.count_lbl.isHidden = true
        }
        else if index == 2
        {
            collection = "third"
             title = segmentarr[Int(index)]
            //self.completelink()
            firstView.isHidden = true
            secondview.isHidden = true
            thirdview.isHidden = false
            fourthView.isHidden = true
             self.firstemptyview.isHidden = true
            self.playlistemptyview.isHidden = true
            self.publishedemptyview.isHidden = true
            self.scheduledemptyview.isHidden = true
            self.playlistcourse()
            
             //self.count_lbl.isHidden = false
        }
        else
        {
            collection = "fourth"
            title = segmentarr[Int(index)]
            //self.completelink()
            firstView.isHidden = true
            secondview.isHidden = true
            thirdview.isHidden = true
            fourthView.isHidden = false
            self.firstemptyview.isHidden = true
            self.playlistemptyview.isHidden = true
            self.publishedemptyview.isHidden = true
            self.scheduledemptyview.isHidden = true
            self.playlistcourse()
            
             //self.count_lbl.isHidden = false
        }
    }

    func intiallink()
    {
        print(tokenstr)
        print(passuserid)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/faculty_courses", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                    print(dat)
                   if dat.isEmpty
                   {
                      self.firstemptyview.isHidden = false
                        if self.collection == "second"
                        {
                             self.scheduledemptyview.isHidden = false
                        }
                        else
                        {
                            self.firstemptyview.isHidden = false
                            self.secondview.isHidden = true
                            self.thirdview.isHidden = true
                            self.fourthView.isHidden = true
                            self.playlistemptyview.isHidden = true
                            self.publishedemptyview.isHidden = true
                            self.scheduledemptyview.isHidden = true
                        }
                    }
                    else
                   {
                    if self.collection == "first"
                    {
                        self.detailarr = dat
                        print(self.detailarr)
                        self.courseid = self.detailarr[0]["course_id"] as! String
                        print(self.courseid)
                        self.secondview.isHidden = true
                        self.thirdview.isHidden = true
                        //self.emptyview.isHidden = true
                        self.collectionview.reloadData()
                        self.Locationlink()
                    }
                    else if self.collection == "second"
                    {
                        self.scheduledarr = dat
                        self.scheduledCollectionview.reloadData()
                        self.ongoinglink()
                    }
                }
                }
                SVProgressHUD.dismiss()
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
        }
       
    }
    
    
    func playlistcourse()
    {
        print(tokenstr)
        print(passuserid)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/faculty_playlist_courses", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                self.publishCourseArr.removeAll()
                self.palylistCourseArr.removeAll()
                if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                    print(dat)
                    if dat.isEmpty
                    {
                        if self.collection == "third"
                        {
                            self.playlistemptyview.isHidden = false
                        }
                        else if self.collection == "fourth"
                        {
                            self.publishedemptyview.isHidden = false
                        }
                    }
                    else
                    {
                    if self.collection == "third"
                    {
                        self.collectionindex2 = 0
                        self.collectionindex3 = 0
                        self.palylistCourseArr = dat
                        print(self.palylistCourseArr)
                        self.courseid = self.palylistCourseArr[0]["course_id"] as! String
                        print(self.courseid)
                        self.playlistCollectionview.reloadData()
                        self.completelink()
                    }
                    else
                    {
                        self.collectionindex2 = 0
                        self.collectionindex3 = 0
                        self.publishCourseArr = dat
                        print(self.publishCourseArr)
                        self.courseid = self.publishCourseArr[0]["course_id"] as! String
                        print(self.courseid)
                        self.publishedtCollectionview.reloadData()
                        self.publishlink()
                    }
                }
                }
                SVProgressHUD.dismiss()
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collection == "first"
        {
            return  detailarr.count
        }
        else if collection == "second"
        {
            return scheduledarr.count
        }
        else if collection == "third"
        {
            return palylistCourseArr.count
        }
        else if collection == "fourth"
        {
            return publishCourseArr.count
        }
        else
        {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collection == "first"
        {
            let cell: ChaptersCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ChaptersCollectionViewCell", for: indexPath) as? ChaptersCollectionViewCell)!
            cell.name.text = self.detailarr[indexPath.row]["course_name"] as! String
       
            if indexPath.item == collectionindex
            {
                cell.roundView.backgroundColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
                cell.name.textColor = UIColor.white
            }
            else
            {
                cell.roundView.backgroundColor = UIColor.white
                cell.name.textColor = UIColor.black
            }
        
            return cell;
        }
        else if collection == "second"
        {
            let cell: ScheduledChapterCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduledChapterCollectionViewCell", for: indexPath) as? ScheduledChapterCollectionViewCell)!
            cell.name.text = self.scheduledarr[indexPath.row]["course_name"] as! String
            
            if indexPath.item == collectionindex1
            {
                cell.roundView.backgroundColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
                cell.name.textColor = UIColor.white
            }
            else
            {
                cell.roundView.backgroundColor = UIColor.white
                cell.name.textColor = UIColor.black
            }
            
            return cell;
        }
        else if collection == "third"
        {
            let cell: PlaylistChapterCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistChapterCollectionViewCell", for: indexPath) as? PlaylistChapterCollectionViewCell)!
            cell.name.text = self.palylistCourseArr[indexPath.row]["course_name"] as! String
            
            if indexPath.item == collectionindex2
            {
                cell.roundView.backgroundColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
                cell.name.textColor = UIColor.white
            }
            else
            {
                cell.roundView.backgroundColor = UIColor.white
                cell.name.textColor = UIColor.black
            }
            
            return cell;
        }
        else if collection == "fourth"
        {
            let cell: PublishedChapterCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedChapterCollectionViewCell", for: indexPath) as? PublishedChapterCollectionViewCell)!
            cell.name.text = self.publishCourseArr[indexPath.row]["course_name"] as! String
            
            if indexPath.item == collectionindex3
            {
                cell.roundView.backgroundColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
                cell.name.textColor = UIColor.white
            }
            else
            {
                cell.roundView.backgroundColor = UIColor.white
                cell.name.textColor = UIColor.black
            }
            
            return cell;
        }
        else
        {
             let cell: PublishedChapterCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedChapterCollectionViewCell", for: indexPath) as? PublishedChapterCollectionViewCell)!
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collection == "first"
        {
            self.collectionindex1 = 0
            self.collectionindex2 = 0
            self.collectionindex3 = 0
            collectionindex = indexPath.item
            self.collectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.collectionview.reloadData()
            courseid = self.detailarr[indexPath.row]["course_id"] as! String
            print(courseid)
            self.Locationlink()
        }
        else if collection == "second"
        {
            self.collectionindex2 = 0
            self.collectionindex = 0
            self.collectionindex3 = 0
            collectionindex1 = indexPath.item
            self.scheduledCollectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.scheduledCollectionview.reloadData()
            courseid = self.scheduledarr[indexPath.row]["course_id"] as! String
            print(courseid)
            self.ongoinglink()
        }
        else if collection == "third"
        {
            self.collectionindex1 = 0
            self.collectionindex = 0
            self.collectionindex3 = 0
            self.collectionindex2 = indexPath.item
            self.playlistCollectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.playlistCollectionview.reloadData()
            self.courseid = self.palylistCourseArr[indexPath.row]["course_id"] as! String
            print(self.courseid)
            self.completelink()
        }
        else if collection == "fourth"
        {
            self.collectionindex2 = 0
            self.collectionindex1 = 0
            self.collectionindex = 0
            self.collectionindex3 = indexPath.item
            print(self.collectionindex3)
            self.publishedtCollectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.publishedtCollectionview.reloadData()
            self.courseid = self.publishCourseArr[indexPath.row]["course_id"] as! String
            print(self.courseid)
            self.publishlink()
        }
    }
  
    @objc func reschdulebtn(sender:UIButton!)
    {
        let status = self.detailsarr[sender.tag-123]["playlist_status"] as! String
        print(status)
        if status == "2"
        {
//            playlistStatus = "2"
//            reschedulestr = "Reschedule"
            let uiAlert = UIAlertController(title: "Reschedule", message: "Please Wait for Admin Approve.", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("Click of default button")
            }))
//            self.completedtableview.reloadRows(at: [NSIndexPath.init(row: sender.tag-123, section: 0) as IndexPath], with: UITableViewRowAnimation.none)
//            let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.approvestatuslink), userInfo: nil, repeats: false)
//            print(timer)
        }
        else
        {
            playlistStatus = "2"
            reschedulestr = "Reschedule"
            let uiAlert = UIAlertController(title: "Reschedule", message: "Do you want to Reschedule this Video?", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("Click of default button")
            }))
            self.completedtableview.reloadRows(at: [NSIndexPath.init(row: sender.tag-123, section: 0) as IndexPath], with: UITableView.RowAnimation.none)
            let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.approvestatuslink), userInfo: nil, repeats: false)
            print(timer)
        }
    }
    
    @objc func approvebtn(sender:UIButton!)
    {
         let status = self.detailsarr[sender.tag-123]["playlist_status"] as! String
        print(status)
        if status == "1"
        {
            let uiAlert = UIAlertController(title: "Approve", message: "Please Wait for Admin Approve.", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("Click of default button")
            }))
//            self.completedtableview.reloadRows(at: [NSIndexPath.init(row: sender.tag-123, section: 0) as IndexPath], with: UITableViewRowAnimation.none)
//            //self.approvestatuslink()
//            let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.approvestatuslink), userInfo: nil, repeats: false)
//            print(timer)
        }
        else
        {
            playlistStatus = "1"
            approvestr = "Approve"
            let uiAlert = UIAlertController(title: "Approve", message: "Please Wait for Admin Approve.", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
        
            uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            print("Click of default button")
            }))
            self.completedtableview.reloadRows(at: [NSIndexPath.init(row: sender.tag-123, section: 0) as IndexPath], with: UITableView.RowAnimation.none)
            //self.approvestatuslink()
            let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.approvestatuslink), userInfo: nil, repeats: false)
            print(timer)
        }
        //completedtableview.reloadData()
    }
    
    @objc func sendbtn(sender:UIButton!)
    {
        sendstr = "send"
        let uiAlert = UIAlertController(title: "Accept Invite", message: "Do you want to Accept this invitation?", preferredStyle: UIAlertController.Style.alert)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { action in
            print("Click of default button")
        }))
        self.completedtableview.reloadRows(at: [NSIndexPath.init(row: sender.tag-123, section: 0) as IndexPath], with: UITableView.RowAnimation.none)
    }
    
    
    @objc func approvestatuslink()
    {
        print(tokenstr)
        print(passuserid)
        print(lecture_id)
        print(courseid)
        print(chap_id)
        print(playlistStatus)
        let params:[String:String] = ["token":tokenstr,"faculty_id":passuserid,"lecture_id":lecture_id,"course_id":courseid,"chapter_id":chap_id,"status":playlistStatus]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/faculty_playlist_status", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
         if let dict = result.value as? Dictionary<String,AnyObject>{
            let dat = dict["result"] as! String
            if dat == "success"
            {
                 self.completelink()
//                print(dat)
//                let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
//                mainview.LC_id = self.lecture_id
//                self.navigationController?.pushViewController(mainview, animated:true)
               SVProgressHUD.dismiss()
            }
           SVProgressHUD.dismiss()
         }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
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

}
extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 1)
        endPoint = CGPoint(x: 1, y: 1)
    }
    
    func creatGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }
}
