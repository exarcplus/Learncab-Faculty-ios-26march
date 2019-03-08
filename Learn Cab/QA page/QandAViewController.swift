//
//  QandAViewController.swift
//  Learn Cab
//
//  Created by Vignesh Waran on 25/02/19.
//  Copyright © 2019 Exarcplus. All rights reserved.
//

import UIKit
import ZRScrollableTabBar
import Alamofire


class QandAViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ZRScrollableTabBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var Collectionview : UICollectionView!
    @IBOutlet weak var Tableview : UITableView!
    @IBOutlet weak var Epmtyview : UIView!
    var courseArr = [Dictionary<String,AnyObject>]()
     var listArr = [Dictionary<String,AnyObject>]()
    var collectionindex : Int!
    @IBOutlet weak var Tabbarview:UIView!
    var tokenstr: String!
    var passuserid: String!
    var Tabbar:ZRScrollableTabBar!
    var myclass : MyClass!
    
    var courseid: String!
    var chap_id : String!
    var lecture_id : String!
    
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
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem?.image = UIImage(named: "Logo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
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
        //        passuserid =  UserDefaults.standard.string(forKey: "id")
        //        print(passuserid)
        //        }
        collectionindex = 0
       
        let item1 = UITabBarItem.init(title:"Studio", image: UIImage.init(named:"studio"), tag: 1)
        item1.image = UIImage.init(named: "studio")?.withRenderingMode(.alwaysOriginal)
        item1.selectedImage = UIImage.init(named: "studioColour")?.withRenderingMode(.alwaysOriginal)
       
        let item2 = UITabBarItem.init(title:"Dashboard", image: UIImage.init(named:"DashBoard"), tag: 2)
        item2.image = UIImage.init(named: "DashBoard")?.withRenderingMode(.alwaysOriginal)
        item2.selectedImage = UIImage.init(named: "DashBoardColour")?.withRenderingMode(.alwaysOriginal)
        let item3 = UITabBarItem.init(title:"Feedback", image: UIImage.init(named:"feedback"), tag: 3)
        item3.image = UIImage.init(named: "feedback")?.withRenderingMode(.alwaysOriginal)
        item3.selectedImage = UIImage.init(named: "feedbackColour")?.withRenderingMode(.alwaysOriginal)
        
        let item4 = UITabBarItem.init(title:"Profile", image: UIImage.init(named:"Profile"), tag: 4)
        item4.image = UIImage.init(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        item4.selectedImage = UIImage.init(named: "ProfileColour")?.withRenderingMode(.alwaysOriginal)
        
        let item5 = UITabBarItem.init(title:"Q&A", image: UIImage.init(named:"qa"), tag: 5)
        item5.image = UIImage.init(named: "qa")?.withRenderingMode(.alwaysOriginal)
        item5.selectedImage = UIImage.init(named: "qacolor")?.withRenderingMode(.alwaysOriginal)
        
        Tabbar = ZRScrollableTabBar.init(items: [item1,item2,item3,item4,item5])
        Tabbar.tintColor = myclass.colorWithHexString(hex: "#000000")
        Tabbar.scrollableTabBarDelegate = self;
        Tabbar.selectItem(withTag: 5)
        Tabbar.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: Tabbarview.frame.size.height);
        Tabbarview.addSubview(Tabbar)
        
       self.Epmtyview.isHidden = true
        
       self.courselist()
    
       // self.intiallink()
    }
    

    func scrollableTabBar(_ tabBar: ZRScrollableTabBar!, didSelectItemWithTag tag: Int32)
    {
        if tag == 1
        {
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)
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
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:false, completion: nil)
        }
        else if tag == 5
        {
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func courselist()
    {
        print(tokenstr)
        print(passuserid)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid]
        ZVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/faculty_playlist_courses", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                self.courseArr.removeAll()
                if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                    print(dat)
                    if dat.isEmpty
                    {
                        
                            self.Epmtyview.isHidden = false
                        
                    }
                    else
                    {
                       
                        self.Epmtyview.isHidden = true
                        
                            self.collectionindex = 0
                            self.courseArr = dat
                            print(self.courseArr)
                            self.courseid = self.courseArr[0]["course_id"] as! String
                            print(self.courseid)
                            self.Collectionview.reloadData()
                            self.listlink()
                        
                    }
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
    
    func listlink()
    {
        if courseid == nil
        {
            self.Epmtyview.isHidden = false
        }
        else
        {
            let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"course_id":courseid]
            ZVProgressHUD.show()
            Alamofire.request("https://manage.learncab.com/faculty_playlist_chapters_qa", method: .post, parameters: params).responseJSON { response in
                
                print(response)
                
                let result = response.result
                print(response)
                // self.publishedemptyview.isHidden = tr
                
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print(dict)
                    self.listArr.removeAll()
                    if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                        print(dat)
                        self.listArr = dat

                        if self.listArr.count != 0
                        {
                           
                            self.Epmtyview.isHidden = true
                        }
                        else{
                            self.Epmtyview.isHidden = false
                        }
                        
                        self.Tableview.reloadData()
                        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
            return courseArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell: PublishedChapterCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedChapterCollectionViewCell", for: indexPath) as? PublishedChapterCollectionViewCell)!
        cell.name.text = self.courseArr[indexPath.row]["course_name"] as! String
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        self.collectionindex = 0
        self.collectionindex = indexPath.item
        print(self.collectionindex)
        self.Collectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        self.Collectionview.reloadData()
        self.courseid = self.courseArr[indexPath.row]["course_id"] as! String
        print(self.courseid)
        self.listlink()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
            return self.listArr.count
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTableViewCell", for: indexPath) as! CompletedTableViewCell
        cell.selectionStyle = .none
        cell.eventlab.text = self.listArr[indexPath.row]["paper"] as! String
        cell.descriptionlab.text = self.listArr[indexPath.row]["chapter"] as! String
        let chapterid = self.listArr[indexPath.row]["chapter_id"] as! String
        print(chapterid)
        chap_id = chapterid
        let count = self.listArr[indexPath.row]["qa_count"] as! Int
        let countstr = String(count)
        
        if countstr == "0"
        {
            cell.countlab.isHidden = true
            cell.countlab.text = countstr
        }
        else{
            cell.countlab.isHidden = false
            cell.countlab.text = countstr
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "QAListViewController") as! QAListViewController
        mainview.courseid = self.courseid
        mainview.chapterid = self.listArr[indexPath.row]["chapter_id"] as! String
        self.navigationController?.pushViewController(mainview, animated:true)
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
