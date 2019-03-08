//
//  VideoPlayerViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 31/01/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import VGPlayer
import SnapKit
import AZDropdownMenu
import Sheeeeeeeeet


class VideoPlayerViewController: UIViewController,VGPlayerViewDelegate,VGPlayerDelegate,UIWebViewDelegate,IQActionSheetPickerViewDelegate{
    var player : VGPlayer = {
        let playeView = VGCustomPlayerView()
        let playe = VGPlayer(playerView: playeView)
        return playe
    }()
    let leftTitles = ["Low","Medium","High"]
    
     var sponser : qulityPop!
    var currentstr : String!
    var url : URL?
    var videostr : String!
    var addvideostr : String!
    var content : String!
    var viewstr : String!
     var bloodgrparr : NSMutableArray!
    @IBOutlet weak var Player : UIView!
    @IBOutlet weak var webview : UIWebView!
    var name : String!
    var dataarr = [Dictionary<String,AnyObject>]()
    @IBOutlet weak var dropMenu : DKDropMenu!
     @IBOutlet var detailswebviewheight : NSLayoutConstraint!
    var curentTime : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewstr)
        bloodgrparr = ["Low","Medium","High"]
        print(bloodgrparr)
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UIApplication.shared.setStatusBarHidden(false, with: .none)
       // UIViewController.attemptRotationToDeviceOrientation()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.myOrientation = .landscape
        title = "VIDEO"
        print(videostr)
        //self.addvideostr = videostr + ".mp4"
        // print(addvideostr)
        
        if currentstr == nil
       {
            let formattedString = videostr.replacingOccurrences(of: " ", with: "%20")
            print("Movie URL: \(String(describing: url))")
            self.url = URL(string: formattedString)
            print( self.url)
            if  let srt = Bundle.main.url(forResource: formattedString, withExtension: "mp4")
            {
                let playerView = self.player.displayView as! VGCustomPlayerView
                playerView.setSubtitles(VGSubtitles(filePath: srt))
            }
        
            self.player.replaceVideo(url!)
            self.player.displayView.titleLabel.text = "VIDEO"
            self.Player.addSubview(self.player.displayView)
            //self.player.seekTime(curentTime)
            self.player.play()
            self.player.backgroundMode = .suspend
            self.player.delegate = self as! VGPlayerDelegate
            self.player.displayView.delegate = self as! VGPlayerViewDelegate
            self.player.displayView.snp.makeConstraints { [weak self] (make) in
                guard let strongSelf = self else { return }
                make.top.equalTo(strongSelf.view.snp.top)
                make.left.equalTo(strongSelf.view.snp.left)
                make.right.equalTo(strongSelf.view.snp.right)
                make.height.equalTo(strongSelf.view.snp.width).multipliedBy(9.0/16.0) // you can 9.0/16.0
            }
        }
        else
       {
            //self.playVideo()
        }
        //curentTime = 00.00
        self.webview.delegate = self
        let font = UIFont.init(name: "Poppins-Light", size: 14)
        webview.scrollView.isScrollEnabled = true
        webview.backgroundColor = .clear
        self.webview.loadHTMLString(content, baseURL: nil)
        //self.playVideo()
    }
    
    
    
    func playVideo()
    {
        print(curentTime)
        let st = formatSecondsToString(curentTime)
        print(st)
        self.player.seekTime(curentTime)
        let formattedString = videostr.replacingOccurrences(of: " ", with: "%20")
        print("Movie URL: \(String(describing: url))")
        self.url = URL(string: formattedString)
        print( self.url)
        if  let srt = Bundle.main.url(forResource: formattedString, withExtension: "mp4") {
            let playerView = self.player.displayView as! VGCustomPlayerView
            playerView.setSubtitles(VGSubtitles(filePath: srt))
        }
        
        self.player.replaceVideo(url!)
        self.player.displayView.titleLabel.text = "VIDEO"
        self.Player.addSubview(self.player.displayView)
        
        self.player.play()
        self.player.backgroundMode = .suspend
        self.player.delegate = self as! VGPlayerDelegate
        self.player.displayView.delegate = self as! VGPlayerViewDelegate
       
        
        self.player.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.top.equalTo(strongSelf.view.snp.top)
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            make.height.equalTo(strongSelf.view.snp.width).multipliedBy(9.0/16.0) // you can 9.0/16.0
            
            UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
            UIApplication.shared.setStatusBarHidden(false, with: .none)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.navigationBar.isHidden = true
         UIApplication.shared.setStatusBarHidden(false, with: .none)
        self.player.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        
        self.player.pause()
    }
    
    func vgPlayer(_ player: VGPlayer, playerDurationDidChange currentDuration: TimeInterval, totalDuration: TimeInterval) {
       // print(currentDuration)
        let current = formatSecondsToString(currentDuration)
        curentTime = currentDuration
         print(curentTime)
        if totalDuration.isNaN {  // HLS
            print(current)
        }
    }
    
func formatSecondsToString(_ secounds: TimeInterval) -> String {
        if secounds.isNaN{
            return "00:00"
        }
        let interval = Int(secounds)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
  
    
    func showDropdown() {
        let menu = AZDropdownMenu(titles: leftTitles)
        if (menu.isDescendant(of: self.view) == true) {
            menu.hideMenu()
        } else {
            menu.showMenuFromView(self.view)
        }
    }
    func itemSelected(withIndex: Int, name: String) {
        print("\(name) selected");
        self.playVideo()
    }

    
    func vgPlayer(_ player: VGPlayer, stateDidChange state: VGPlayerState) {
        print(state)
    }
    
//Full View
    func vgPlayerView(_ playerView: VGPlayerView, willFullscreen fullscreen: Bool) {
        if playerView.isFullScreen == true{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.myOrientation = .landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(false, with: .none)
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.myOrientation = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(false, with: .none)
        }
    }
    
//back Button
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        if playerView.isFullScreen {
            //            playerView.exitFullscreen()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.myOrientation = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(false, with: .none)
        } else {
            UIApplication.shared.setStatusBarHidden(false, with: .none)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
//POpup Qulity selection
    func vgPlayerView(qulityScreen playerView: VGPlayerView) {
//        self.player.pause()
        if playerView.isFullScreen {
            
             SRPopView.sharedManager().currentColorScheme = kSRColorSchemeLight
            SRPopView.show(withButton: Any!.self, andArray: leftTitles, andHeading: "Select Quality", andCallback: { (itemPickedBlock) in
                print(itemPickedBlock)
                UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
                UIApplication.shared.setStatusBarHidden(false, with: .none)
//                self.playVideo()
//                self.player.seekTime(self.curentTime)
//                self.player.play()
               
            })
        }
        else
        {
            SRPopView.sharedManager().currentColorScheme = kSRColorSchemeLight
            SRPopView.show(withButton: Any!.self, andArray: leftTitles, andHeading: "Select Quality", andCallback: { (itemPickedBlock) in
                print(itemPickedBlock)
//                self.player.play()
                UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
                UIApplication.shared.setStatusBarHidden(false, with: .none)
//                self.playVideo()
//                self.player.seekTime(self.curentTime)
//                self.player.play()
               
            })
        }
       
    }
    
    func vgPlayerView(didDisplayControl playerView: VGPlayerView) {
        UIApplication.shared.setStatusBarHidden(!playerView.isDisplayControl, with: .none)
    }
    
        func actionSheetPickerView(_ pickerView: IQActionSheetPickerView!,didSelectTitles titles: NSArray!)
    {
            let str = titles.componentsJoined(by: " ")
            print(str)
        self.playVideo()
    }
    
   
}

