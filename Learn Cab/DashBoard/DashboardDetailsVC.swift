//
//  DashboardDetailsVC.swift
//  Learn Cab
//
//  Created by Vignesh Waran on 12/02/19.
//  Copyright © 2019 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire

class DashboardDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tablelist: UITableView!
    var detailarr = [Dictionary<String,AnyObject>]()
    var listarr = [Dictionary<String,AnyObject>]()
    @IBOutlet weak var nodata: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(detailarr)
        print(detailarr.count)
        if self.detailarr.count != 0
        {
            self.listarr = self.detailarr[0]["datas"] as! [Dictionary<String, AnyObject>]
            print(self.listarr)
             print(self.listarr.count)
            self.tablelist.reloadData()
            nodata.isHidden = true
        }
        else{
            self.tablelist.reloadData()
            nodata.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(self.listarr.count)
        return self.listarr.count
       // return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardDetailsTableViewCell", for: indexPath) as! DashboardDetailsTableViewCell
        cell.selectionStyle = .none
       let str1 = self.listarr[indexPath.row]["student_id"] as! String
        cell.stdid.text = str1
        let str2 = self.listarr[indexPath.row]["discount"] as! AnyObject
        print(str2)
        let distr = String(describing: str2)
        
        cell.discount.text = distr + "%"
        cell.course_name.text = self.listarr[indexPath.row]["course_name"] as! String
        let str4 = self.listarr[indexPath.row]["chapter_name"] as! String
        cell.chapter.text = str4
        let str5 = self.listarr[indexPath.row]["datetime"] as! String
        
        var dFormatter = DateFormatter()
        dFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dtt = dFormatter.date(from: str5);
        print(dtt)
        let chagformater = DateFormatter();
        chagformater.dateFormat = "dd MMM yyyy"
        let dtstr = chagformater.string(from: dtt!)
        print(dtstr)
        
        
        cell.datetime.text = dtstr
        
        let str6 = self.listarr[indexPath.row]["lecture_credits"] as! String
        cell.credit.text = str6
        
        //let namestr = self.detailarr[indexPath.row]["studio_name"] as! String
        return cell
    }

    @IBAction func backbtn(_ sender : UIButton){
        
       self.navigationController?.popViewController(animated: true)
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
