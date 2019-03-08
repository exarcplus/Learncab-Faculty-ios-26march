//
//  PlayListViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 20/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class PlayListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var palylistname : UILabel!
    var expandTableview:VBHeader = VBHeader()
    var cell : PlayListExpendableCell!
    var arrStatus:NSMutableArray = []
    var tokenstr : String!
    var passuserid : String!
    var dataarr = [Dictionary<String,AnyObject>]()
    var playlistarr = [Dictionary<String,AnyObject>]()
    var LC_id : String!
    var headername : String!
    var headerarr : NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
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
        print(playlistarr)
        palylistname.text = headername
        myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  playlistarr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        cell = tableView.dequeueReusableCell(withIdentifier: "PlayListExpendableCell", for: indexPath) as! PlayListExpendableCell
        cell.playlistname.text = self.playlistarr[indexPath.row]["title"] as! String

        let  urlstr = self.playlistarr[indexPath.row]["url"] as! String
        print(urlstr)
        let url1 : String = urlstr
        let url: URL? = NSURL(fileURLWithPath: url1) as URL
        let pathExtention = url?.pathExtension
        let imageExtensions = ["png", "jpg", "gif"]
        let videoExtentions = ["mp4","mov"]
        let notesExtentions = ["svg"]
        let pdfExtentions = ["pdf"]
        let docExtentions = ["doc"]
        let gifExtentions = ["zip","html"]
        if imageExtensions.contains(pathExtention!)
        {
            cell.bannerimg.image = UIImage.init(named: "Image.png")
        }
        else if videoExtentions.contains(pathExtention!)
        {
            cell.bannerimg.image = UIImage.init(named: "videoplay.png")
        }
        else if notesExtentions.contains(pathExtention!)
        {
            cell.bannerimg.image = UIImage.init(named: "notes.png")
        }
        else if pdfExtentions.contains(pathExtention!)
        {
            cell.bannerimg.image = UIImage.init(named: "pdf.png")
        }
        else if docExtentions.contains(pathExtention!)
        {
            cell.bannerimg.image = UIImage.init(named: "doc.png")
        }
        else if gifExtentions.contains(pathExtention!)
        {
            cell.bannerimg.image = UIImage.init(named: "Zip.png")
        }
        else
        {
            if urlstr.characters.count == 10
            {
                cell.bannerimg.image = UIImage.init(named: "videoplay.png")
            }
            else
            {
                cell.bannerimg.image = UIImage.init(named: "desc.png")
            }
            
        }
        let img = self.playlistarr[indexPath.row]["url"] as! String
        //cell.bannerimg.sd_setImage(with: URL(string: img))
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let  urlstr = self.playlistarr[indexPath.row]["url"] as! String
        let url1 : String = urlstr
        let url: URL? = NSURL(fileURLWithPath: url1) as URL
        let pathExtention = url?.pathExtension
        let imageExtensions = ["png", "jpg", "gif"]
        let videoExtentions = ["mp4","mov"]
        let notesExtentions = ["svg"]
        let pdfExtentions = ["pdf","doc","zip"]
        let htmlExtentions = ["html"]
        if imageExtensions.contains(pathExtention!)
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlaylistImgViewController") as! PlaylistImgViewController
            mainview.imgstr = self.playlistarr[indexPath.row]["url"] as! String
            mainview.discription = self.playlistarr[indexPath.row]["content"] as! String
            mainview.titlestr = self.playlistarr[indexPath.row]["title"] as! String
            print(self.playlistarr[indexPath.row]["url"] as! String)
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else if videoExtentions.contains(pathExtention!)
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
            //let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "VideoPlayerViewViewController") as! VideoPlayerViewViewController
            mainview.videostr = self.playlistarr[indexPath.row]["url"] as! String
            mainview.content = self.playlistarr[indexPath.row]["content"] as! String
           // kViewControllerVideoID = self.playlistarr[indexPath.row]["url"] as! String
           self.navigationController?.pushViewController(mainview, animated:true)
        }
        else if notesExtentions.contains(pathExtention!)
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
            mainview.notes = self.playlistarr[indexPath.row]["url"] as! String
            mainview.titlestr = self.playlistarr[indexPath.row]["title"] as! String
//            mainview.lecture_id = LC_id
            print(self.playlistarr[indexPath.row]["url"] as! String)
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else if pdfExtentions.contains(pathExtention!)
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            mainview.pdfstr = self.playlistarr[indexPath.row]["url"] as! String
            mainview.content = self.playlistarr[indexPath.row]["content"] as! String
            mainview.titlestr = self.playlistarr[indexPath.row]["title"] as! String
            print(self.playlistarr[indexPath.row]["url"] as! String)
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else if htmlExtentions.contains(pathExtention!)
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            mainview.quizstr = self.playlistarr[indexPath.row]["url"] as! String
            mainview.titlestr = self.playlistarr[indexPath.row]["title"] as! String
            print(self.playlistarr[indexPath.row]["url"] as! String)
            self.navigationController?.pushViewController(mainview, animated:true)
        }
        else
        {
            if urlstr.characters.count == 10
            {
                let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "VideoPlayerViewViewController") as! VideoPlayerViewViewController
                mainview.videostr = self.playlistarr[indexPath.row]["url"] as! String
                mainview.content = self.playlistarr[indexPath.row]["content"] as! String
                kViewControllerVideoID = self.playlistarr[indexPath.row]["url"] as! String
                self.navigationController?.pushViewController(mainview, animated:true)
            }
            else
            {
                let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
                mainview.content = self.playlistarr[indexPath.row]["content"] as! String
                mainview.titlestr = self.playlistarr[indexPath.row]["title"] as! String
                print(self.playlistarr[indexPath.row]["url"] as! String)
                self.navigationController?.pushViewController(mainview, animated:true)
            }
            
        }
    }
}
extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
