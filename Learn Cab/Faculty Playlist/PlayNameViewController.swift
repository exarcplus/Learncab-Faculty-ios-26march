//
//  PlayNameViewController.swift
//  LC Faculty
//
//  Created by Exarcplus on 30/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import EHHorizontalSelectionView

class PlayNameViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,EHHorizontalSelectionViewProtocol {

    var tokenstr : String!
    var passuserid : String!
    var LC_id : String!
   var dataarr = [Dictionary<String,AnyObject>]()
   
    @IBOutlet var myTableView: UITableView!
     @IBOutlet var listview: UIView!
     @IBOutlet var aboutview: UIView!
    // @IBOutlet var QandAview: UIView!
     @IBOutlet weak var topview: EHHorizontalSelectionView!
     var segmentarr = [String]()
    
    var description_str: String!
     @IBOutlet weak var nodesc: UILabel!
    @IBOutlet weak var desc_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        print(LC_id)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
            
        }
        
        self.nodesc.isHidden = true
        
        segmentarr = ["PLAYLIST","ABOUT"]
        topview.delegate = self as! EHHorizontalSelectionViewProtocol
        
        listview.isHidden = false
        aboutview.isHidden = true
        //QandAview.isHidden = true
        
         self.intiallink()
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
            listview.isHidden = false
            aboutview.isHidden = true
            //QandAview.isHidden = true
           
        }
        else if index == 1
        {
            listview.isHidden = true
            //QandAview.isHidden = true
            aboutview.isHidden = false
            
            if self.description_str != ""
            {
                self.nodesc.isHidden = true
                self.desc_lbl.text = self.description_str
            }
            else
            {
                self.nodesc.isHidden = false
                 self.desc_lbl.text = ""
            }
           
        }
        else
        {
//            listview.isHidden = true
//            aboutview.isHidden = true
//            QandAview.isHidden = false
//
//            self.QATable.reloadData()
            
        }
    }
    
    func intiallink()
    {
        print(tokenstr)
        print(passuserid)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"lecture_id":LC_id]
        SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/faculty_playlist", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                if let dat = dict["data"] as? [Dictionary<String,AnyObject>]  {
                    print(dat)
                    self.dataarr = dat
                    print(self.dataarr.count)
                    print(self.dataarr)
                    
                    
                    
                    self.myTableView?.reloadData()
                    SVProgressHUD.dismiss()
                }
                else
                {
                    //self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                    SVProgressHUD.dismiss()
                }
            }
        }
        
    }
    
  
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return  dataarr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistNameTableViewCell", for: indexPath) as! PlaylistNameTableViewCell
            cell.selectionStyle = .none
            cell.chptname.text = self.dataarr[indexPath.row]["playlist_name"] as! String
            return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
            mainview.playlistarr = self.dataarr[indexPath.row]["features"] as! [Dictionary<String, AnyObject>]
            mainview.headername = self.dataarr[indexPath.row]["playlist_name"] as! String
            self.navigationController?.pushViewController(mainview, animated:true)
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
