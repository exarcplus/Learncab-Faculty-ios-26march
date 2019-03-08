//
//  PlaylistQulityViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 05/04/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit

class PlaylistQulityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var videoString : String!
    var Descrt : String!
    var seekTm : String!
    var listarr = [String]()
    var friststr : String!
     @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        friststr = "First"
        listarr = ["Low","Medium","High"]
        print(listarr)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  listarr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListQuiltyTableViewCell", for: indexPath) as! PlayListQuiltyTableViewCell
        cell.selectionStyle = .none
        cell.listname.text = self.listarr[indexPath.row]  as! String
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
//        mainview.playlistarr = self.dataarr[indexPath.row]["features"] as! [Dictionary<String, AnyObject>]
//        mainview.headername = self.dataarr[indexPath.row]["playlist_name"] as! String
//        self.navigationController?.pushViewController(mainview, animated:true)
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
