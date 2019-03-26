//
//  DashboardViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 06/12/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import AFNetworking
import ZRScrollableTabBar
import TCProgressBar
import EHHorizontalSelectionView
import Alamofire
import SVProgressHUD



class DashboardViewController: UIViewController,ZRScrollableTabBarDelegate,EHHorizontalSelectionViewProtocol,IQActionSheetPickerViewDelegate,ChartViewDelegate{
    //var aaChartView : AAChartView!
    var Tabbar:ZRScrollableTabBar!
    @IBOutlet weak var Tabbarview:UIView!
    //@IBOutlet weak var chartView:UIView!
    @IBOutlet weak var progressbar1:UIView!
    @IBOutlet weak var progressbar2:UIView!
    @IBOutlet weak var progressbar3:UIView!
    @IBOutlet weak var progressbar4:UIView!
     var segmentarr = [String]()
    @IBOutlet weak var monthtxt: UITextField!
    @IBOutlet weak var yeartxt: UITextField!
    var datestring: String!
    @IBOutlet weak var buttonview: EHHorizontalSelectionView!
    var myclass : MyClass!
    var datearr = [Date]()
    var detstr: String!
     @IBOutlet weak var datelbl: UILabel!
    var monthndyr: String!
    var tokenstr : String!
    var passuserid : String!
    
    var passmontyr: String!
    var daysarr = [String]()
     var yearsarr = [String]()
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var total_count: UILabel!
    
     @IBOutlet weak var Earned_lbl: UILabel!
     @IBOutlet weak var credit_lbl: UILabel!
    var TotalArr = [Dictionary<String,AnyObject>]()
    var subdatas = [Dictionary<String,AnyObject>]()
    var countarr = [Int]()
    @IBOutlet weak var emptyview: UIView!
    var day: String!
    var day_no: Int!
    var TotalArr1 = [Dictionary<String,AnyObject>]()
    
     var alert: JonAlert!
    
    @IBOutlet weak var chartView:LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem?.image = UIImage(named: "Logo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
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
            passuserid = newResult["id"] as! String
            print(passuserid)
            
        }
        
        self.emptyview.isHidden = true

        self.title = "DASHBOARD"
        self.chartView.backgroundColor = UIColor.white
       
        
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
        
        Tabbar = ZRScrollableTabBar.init(items: [item1,item2,item3,item4,item5])
        Tabbar.tintColor = myclass.colorWithHexString(hex: "#000000")
        Tabbar.scrollableTabBarDelegate = self;
        Tabbar.selectItem(withTag: 2)
        Tabbar.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: Tabbarview.frame.size.height);
        Tabbarview.addSubview(Tabbar)
        
        
        let date = NSDate()
        print(date)
        let day = 24*3600;
        let numda = day*(365*5);
        let chagformater = DateFormatter();
        chagformater.dateFormat = "yyyy/MM/dd"
        let tstr = chagformater.string(from: date as Date)
        detstr = tstr
        print(detstr)
        for day in (-30...0).reversed()
        {
            self.datearr.append(Date(timeIntervalSinceNow: Double(day * 86400)))
            print(self.datearr)
        }
        
       
        
        var dFormatter = DateFormatter()
        dFormatter.dateFormat = "yyyy/MM/dd"
        let dtt = dFormatter.date(from: detstr);
        print(detstr)
        let chagformater1 = DateFormatter();
        chagformater1.dateFormat = "yyyy-MM"
        passmontyr = chagformater1.string(from: dtt!)
        print(passmontyr)
        
        let chagformater2 = DateFormatter();
        chagformater2.dateFormat = "MMM"
        self.monthtxt.text = chagformater2.string(from: dtt!)
        
       
        
        let chagformater3 = DateFormatter();
        chagformater3.dateFormat = "yyyy"
        self.yeartxt.text = chagformater3.string(from: dtt!)
        
        self.day = ""
    
        
        //self.setUpTheAAChartViewOne()
        
        self.dashboardlink()
        
        // Do any additional setup after loading the view.
        Alert()
    }

    private func Alert()
    {
        //toast = JYToast()
        alert = JonAlert()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .portrait
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
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
    
    func dashboardlink()
    {
        print(passmontyr)
        
        let params:[String:String] = ["monthyear":passmontyr]
        //SVProgressHUD.show()
       // ZVProgressHUD.show(with: "Loading", delay: 0.0)
        
        ZVProgressHUD.show()
        
        Alamofire.request("https://manage.learncab.com/faculty_report/"+passuserid+"/?token="+tokenstr, method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dat = result.value as? Dictionary<String,AnyObject>
            {
                let res = dat["result"] as! String
                if res == "success"
                {
                    let str = dat["total_count"] as! Int
                    self.total_count.text = String(str)
                    
                    let data = dat["data"] as? [Dictionary<String,AnyObject>]
                    print(data)
                    self.TotalArr = data!
                    print(self.TotalArr)
                    print(self.TotalArr.count)
                    self.daysarr.removeAll()
                    self.countarr.removeAll()
                    self.subdatas.removeAll()
                    self.TotalArr1.removeAll()
                    
                    if self.TotalArr.count != 0
                    {
                        for i in 0 ..< self.TotalArr.count
                        {
                            let sub = self.TotalArr[i]["datas"] as? [Dictionary<String,AnyObject>]
                            if sub?.count != 0
                            {
                                 self.TotalArr1.append(self.TotalArr[i])
                                
                                 print(sub?.count)
                                let counts = sub?.count
                                print(counts)
                                self.countarr.append(counts!)
                                print(self.countarr)
                            

                                let dtstr = self.TotalArr[i]["date"] as! String
                                print(dtstr)
                                var dFormatter = DateFormatter()
                                dFormatter.dateFormat = "yyyy-MM-dd"
                                let dtt = dFormatter.date(from: dtstr);
                                print(dtt)
                                let chagformater = DateFormatter();
                                chagformater.dateFormat = "dd MMM"
                                let dt = chagformater.string(from: dtt!)
                                print(dt)
                                self.daysarr.append(dt)
                                
                               
                                let sub1 = (self.TotalArr[i]["datas"] as? [Dictionary<String,AnyObject>])!
                                print(sub1.count)
                                
                                for i in 0 ..< sub1.count
                                {
                                    let co = sub1[i]
                                    print(co)
                                    self.subdatas.append(co)
                                    
                                }
                               
                                print(self.subdatas.count)
                                print(self.subdatas)
                                

                            }
                            else{
                                
                            }
                        }
                        
                        print(self.daysarr)
                        print(self.subdatas.count)
                        print(self.subdatas)
                        print(self.countarr)
                        self.Earned_lbl.text = String(self.subdatas.count)
                        
                        print(self.TotalArr1)
                        
                        if self.subdatas.count != 0
                        {
                         
                            self.setUpTheAAChartViewOne()
                            self.emptyview.isHidden = true
                            
                        }
                        else
                        {
                            self.emptyview.isHidden = false
                            self.daylbl.text = ""
                            self.credit_lbl.text = ""
                        }
                    }
                    else{
                        
                    }
                   
                    //self.setUpTheAAChartViewOne()
                   
                }
                
            }
            else
            {
                self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LearnCab"), withAlert:self.myclass.StringfromKey(Key: "checkinternet"), withIdentifier:"internet")
                SVProgressHUD.dismiss()
            }
            //SVProgressHUD.dismiss()
            ZVProgressHUD.dismiss()
        }
    }

    func setUpTheAAChartViewOne() {
       
            var dFormatter = DateFormatter()
            dFormatter.dateFormat = "yyyy-MM"
            let dtt = dFormatter.date(from: passmontyr);
            print(dtt)
       
        let chagformater2 = DateFormatter();
        chagformater2.dateFormat = "MMMM yyyy"
        monthndyr = chagformater2.string(from: dtt!)
        print(monthndyr)
        
        print(self.daysarr)
        print(self.subdatas.count)
        print(self.countarr)
        
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        // chartView.lineData
        chartView.setScaleEnabled(false) //--> //scrolling view
        
        chartView.drawMarkers = false
        
        let l = chartView.legend
        l.wordWrapEnabled = false
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        //l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 2
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.drawGridLinesEnabled = false

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        //xAxis.axisMinimum = 0
        xAxis.axisLineDashPhase = 1
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        //xAxis.setLabelCount(5, force: true)
       // xAxis.valueFormatter = IndexAxisValueFormatter(values: daysarr)
        print(self.daysarr.count)
        if self.daysarr.count > 10
        {
            xAxis.labelCount = 5
        }else
        {
            xAxis.labelCount = daysarr.count
        }
       
        
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
        //yAxis.setLabelCount(5, force: false)
        yAxis.labelTextColor = .black
        yAxis.labelPosition = .outsideChart
        yAxis.axisLineColor = .black
        
       // chartView.drawMarkers = true
        
        chartView.rightAxis.enabled = false
        //chartView.legend.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInCubic)
        
       self.setChart(dataEntryX: daysarr, dataEntryY: countarr)
        
        //self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
        
    }
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Int]) {
        
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<forX.count{
//             print(forX[i])
//             let dataEntry = ChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(countarr[i]))
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(forY[i]))
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
    
         print(dataEntries)
        
                let set1 = LineChartDataSet(values: dataEntries, label: "LearnCab")
                set1.axisDependency = .left
                 set1.setColor(UIColor(red: 66/255, green: 165/255, blue: 245/255, alpha: 1))
                //set1.setColors(ChartColorTemplates.vordiplom(), alpha: 1)
                set1.setCircleColor(UIColor(red: 66/255, green: 165/255, blue: 245/255, alpha: 1))
                set1.valueTextColor = UIColor.black
                set1.lineWidth = 4
                set1.circleRadius = 5
                set1.fillAlpha = 1
                //set1.fillColor = UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1)
                set1.highlightColor = UIColor(red: 123/255, green: 154/255, blue: 96/255, alpha: 1) // mark line color
                set1.drawCircleHoleEnabled = true
                set1.mode = .cubicBezier
                set1.drawHorizontalHighlightIndicatorEnabled = false // mark
                set1.drawVerticalHighlightIndicatorEnabled = false  // mark
                set1.drawIconsEnabled = true
    
                let gradient = getGradientFilling()
                set1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
                set1.drawFilledEnabled = true
                set1.axisDependency = .left
        
               // set1.formLineWidth = 1.0
                //set1.formSize = 15.0
        
                let data = LineChartData(dataSets: [set1])
                data.setValueTextColor(.black)
                data.setValueFont(.systemFont(ofSize: 10))
                let formatter = NumberFormatter()
                formatter.numberStyle = .none
                formatter.maximumFractionDigits = 2
                formatter.multiplier = 1.0
                formatter.percentSymbol = "%"
                formatter.zeroSymbol = ""
                data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
                chartView.data = data
        
//                let data = LineChartData(dataSets: [set1])
//                data.setValueTextColor(.black)
//                data.setValueFont(.systemFont(ofSize: 10))
//               chartView.data = data
//
                chartView.data?.highlightEnabled = true
        

    }
    func getGradientFilling() -> CGGradient {
        // Setting fill gradient color
        let coloTop = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1).cgColor
        // Colors of the gradient
        let gradientColors = [coloTop, colorBottom] as CFArray
        // Positioning of the gradient
        let colorLocations: [CGFloat] = [1.0, 0.0]
        // Gradient Object
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }


    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
//    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight)
//    {
        NSLog("chartValueSelected");

        let str1 = entry.x
        let str2 = entry.y
        print(str1)
        print(str2)

        self.day_no = Int(str1)
        
        var s = ""
        let xvalue = Int(str1)
        print(xvalue)
        for i in xvalue..<daysarr.count{
            
            if s == ""
            {
               self.day = daysarr[i]
                print(self.day)
                
                self.daylbl.text = self.day
                
                s = "str"
            }
            else{
                
            }
            
        }
        
        let yvalue = Int(str2)
        let changevalue = String(yvalue)
        //let newString = yvalue.replacingOccurrences(of: ".0", with: "")
        self.credit_lbl.text = changevalue + " Credits"

        chartView.drawMarkers = true
        
        let marker = BalloonMarker(color: UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1), font: .systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker

        self.chartView.centerViewToAnimated(xValue: entry.x, yValue: entry.y,
                                            axis: self.chartView.data!.getDataSetByIndex(highlight.dataSetIndex).axisDependency,
                                            duration: 1)
    }


    @IBAction func monthbtn(_ sender: UIButton)
    {
        var arr = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        
        ActionSheetStringPicker.show(withTitle: "Month", rows: arr , initialSelection: 0,doneBlock: {
            picker, value, index in
            self.monthtxt.text = index as? String
            let str = index as? String
            print(str)
            
            var dFormatter = DateFormatter()
            dFormatter.dateFormat = "yyyy/MM/dd"
            let dtt = dFormatter.date(from: self.detstr);
            print(dtt)
            
            
            let dtstr = self.monthtxt.text! + " " + self.yeartxt.text!
            
            var dFormatter1 = DateFormatter()
            dFormatter1.dateFormat = "MMMM yyyy"
            let dtt1 = dFormatter1.date(from: dtstr);
            print(dtt1)

            
            if dtt! > dtt1!
            {
                let chagformater1 = DateFormatter();
                chagformater1.dateFormat = "yyyy-MM"
                self.passmontyr = chagformater1.string(from: dtt1!)
                print(self.passmontyr)
                
                self.daylbl.text = ""
                self.credit_lbl.text = ""
                self.chartView.drawMarkers = false
                self.dashboardlink()
            }
            else if dtt! == dtt1!
            {
                
                let chagformater1 = DateFormatter();
                chagformater1.dateFormat = "yyyy-MM"
                self.passmontyr = chagformater1.string(from: dtt1!)
                print(self.passmontyr)
                
                self.daylbl.text = ""
                self.credit_lbl.text = ""
                self.chartView.drawMarkers = false
                self.dashboardlink()
            }
            else
            {
                 self.myclass.ShowsinglebutAlertwithTitle(title: self.myclass.StringfromKey(Key: "LEARN CAB"), withAlert:self.myclass.StringfromKey(Key: "No Data! Only previous data can see."), withIdentifier:"No Data! Only previous data can see.")
                //JonAlert.show(message: "No Data! Only previous data can see.",duration: 5.0)
            }
            
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        self.view.endEditing(true)
        
    }
    @IBAction func yearbtn(_ sender: UIButton)
    {
        var dFormatter = DateFormatter()
        dFormatter.dateFormat = "yyyy-MM"
        let dtt = dFormatter.date(from: passmontyr);
        print(dtt)
        
        let chagformater = DateFormatter();
        chagformater.dateFormat = "yyyy"
        let yrint = Int(chagformater.string(from: dtt!))
        print(yrint)
        
        var arr = ["0","1","2","3","4","5"]

        for i in 0 ..< arr.count
        {
            let dt1 = arr[i]
            print(dt1)
            if dt1 == "0"
            {
                let dt =  yrint!
                print(dt)
                let ystr = String(dt)
                print(ystr)
                self.yearsarr.append(ystr)
            }
            else if dt1 == "1"
            {
                let dt =  yrint! - 1
                print(dt)
                let ystr = String(dt)
                print(ystr)
                self.yearsarr.append(ystr)
            }
            else if dt1 == "2"
            {
                let dt =  yrint! - 2
                print(dt)
                let ystr = String(dt)
                print(ystr)
                self.yearsarr.append(ystr)
            }
            else if dt1 == "3"
            {
                let dt =  yrint! - 3
                print(dt)
                let ystr = String(dt)
                print(ystr)
                self.yearsarr.append(ystr)
            }
            else if dt1 == "4"
            {
                let dt =  yrint! - 4
                print(dt)
                let ystr = String(dt)
                print(ystr)
                self.yearsarr.append(ystr)
            }
            else
            {
                let dt =  yrint! - 5
                print(dt)
                let ystr = String(dt)
                print(ystr)
                self.yearsarr.append(ystr)
            }
           
        }
        print(self.yearsarr)

        ActionSheetStringPicker.show(withTitle: "Month", rows: yearsarr , initialSelection: 0,doneBlock: {
            picker, value, index in
            self.yeartxt.text = index as? String
            
            let dtstr = self.monthtxt.text! + " " + self.yeartxt.text!
            
            var dFormatter1 = DateFormatter()
            dFormatter1.dateFormat = "MMM yyyy"
            let dtt1 = dFormatter1.date(from: dtstr);
            print(dtt1)
            let chagformater1 = DateFormatter();
            chagformater1.dateFormat = "yyyy-MM"
            self.passmontyr = chagformater1.string(from: dtt1!)
            print(self.passmontyr)
            
            self.daylbl.text = ""
            self.credit_lbl.text = ""
            self.chartView.drawMarkers = false
            //JonAlert.show(message: "Loading..!",duration: 5.0)
                
            self.dashboardlink()
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        self.view.endEditing(true)
        
       
    }
    
    func numberOfItems(inHorizontalSelection hSelView: EHHorizontalSelectionView) -> UInt {
        if (hSelView == buttonview)
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
            title = segmentarr[Int(index)]
        }
        else if index == 1
        {
            title = segmentarr[Int(index)]
        }
        else if index == 2
        {
            title = segmentarr[Int(index)]
        }
    }
    
    @IBAction func detailsbtn(_ sender : UIButton)
    {
    
        print(self.daysarr)
        print(self.day)
         print(self.day_no)
        print(self.TotalArr1)
        
        var dd = ""
        
        if self.day != ""
        {
           for i in day_no..<TotalArr1.count
           {
                if dd == ""
                {
                  let pass_arr = TotalArr1[i]
                    print(pass_arr)
                    
                    let nav = self.storyboard!.instantiateViewController(withIdentifier: "DashboardDetailsVC") as! DashboardDetailsVC
                    nav.detailarr = [pass_arr]
                    self.navigationController?.pushViewController(nav, animated: true)
                    
                    dd = "str"
                }
                else
                {
                    
                }
            
            }
            
        }
        else
        {
            
        }
        //let nav = self.storyboard!.instantiateViewController(withIdentifier: "DashboardDetailsVC") as! DashboardDetailsVC
        //nav.detailarr = TotalArr
        //self.navigationController?.pushViewController(nav, animated: true)

    }
}

extension DashboardViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return daysarr[Int(value) % daysarr.count]
        //return format(value: month.count)
    }
    
}
