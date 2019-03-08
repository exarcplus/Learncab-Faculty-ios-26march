//
//  VideoPlayerViewViewController.swift
//  LC Faculty
//
//  Created by Exarcplus on 03/04/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import ARKit
import AVFoundation
import MediaPlayer
import MobileCoreServices
import BrightcovePlayerUI
import BrightcovePlayerSDK
import GoneVisible



var kViewControllerPlaybackServicePolicyKey = "BCpkADawqM2vBBhhvlngk1o5rU1EXNttB6Q7qzZ8RxbIey8ep-7JJjmyWpLP67R7EifVPr63WgN9qkdyDiOmF5oSLTaXbB5k6lO19VrHnm_7vVoRliKnqTOIJK98w9zMLbYl41duH8vQd51k"
var kViewControllerAccountID = "5797077890001"
//
var kViewControllerVideoID = ""

//BCOVPlaybackControllerDelegate
class VideoPlayerViewViewController: UIViewController,BCOVPlaybackControllerDelegate {

    var voideID : String!

    let sharedSDKManager = BCOVPlayerSDKManager.shared()
    let playbackService = BCOVPlaybackService(accountId: kViewControllerAccountID, policyKey: kViewControllerPlaybackServicePolicyKey)
    var playbackController :BCOVPlaybackController
    var preferredPeakBitRate: Double!
    
    @IBOutlet weak var playerview : UIView!
    var videostr : String!
    var content : String!
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    @IBOutlet weak var buttomview : UIView!
    @IBOutlet weak var NXview : UIView!
    @IBOutlet weak var Prevview : UIView!
    @IBOutlet weak var Npview : UIView!
    @IBOutlet weak var webview : UIWebView!
    
    var landscapeOnly = false
    
    var controllername : String!
    required init?(coder aDecoder: NSCoder) {


        playbackController = (sharedSDKManager?.createPlaybackController())!
        super.init(coder: aDecoder)
        playbackController.delegate = self
        playbackController.isAutoAdvance = true
        playbackController.isAutoPlay = true
        playbackController.setAllowsExternalPlayback(true)
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let i = navigationController?.viewControllers.index(of: self)
        UserDefaults.standard.set(i, forKey:"nav")
        UserDefaults.standard.synchronize()
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        self.navigationController?.navigationBar.isHidden = false

        
        kViewControllerVideoID = videostr

        var options = BCOVPUIPlayerViewOptions()
        options.presentingViewController = self
        var controlsView = BCOVPUIBasicControlView.withVODLayout()



        // Set up our player view. Create with a standard VOD layout.
        var playerView = BCOVPUIPlayerView(playbackController: self.playbackController, options: nil, controlsView: controlsView)

        // full Screen button event function
        var screenModeButton = playerView?.viewWithTag((BCOVPUIViewTag.buttonScreenMode).rawValue) as? UIControl
        screenModeButton?.removeTarget(nil, action: nil, for: .allTouchEvents)
        landscapeOnly = false
        screenModeButton?.addTarget(self, action: #selector(self.handleScreenModeButton(_:)), for: .touchUpInside)

        // Install in the container view and match its size.
        playerView?.frame = self.playerview.bounds
        playerView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.playerview.addSubview(playerView!)

        requestContentFromPlaybackService()
        
        self.Prevview.isHidden = true
        self.NXview.isHidden = true
        self.Npview.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "VIDEO"
        self.navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    @objc func handleScreenModeButton(_ sender: Any) {
        if landscapeOnly == true
        {
            landscapeOnly = false
            playbackController.play()
        
            self.Prevview.visible()
            self.NXview.visible()
            self.Npview.visible()
            self.buttomview.visible()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.myOrientation = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(false, with: .none)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
             //self.navigationController?.navigationBar.isHidden = false
        }
        else{
            
            landscapeOnly = true
            
            self.Prevview.gone()
            self.NXview.gone()
            self.Npview.gone()
            self.buttomview.gone()
            
    
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.myOrientation = .landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(true, with: .none)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
           //  self.navigationController?.navigationBar.isHidden = true
        }

    }
    
    
    func requestContentFromPlaybackService() {
        playbackService?.findVideo(withVideoID: "ref:"+kViewControllerVideoID, parameters: nil) { (video: BCOVVideo?, jsonResponse: [AnyHashable: Any]?, error: Error?) -> Void in

            if let v = video {
                print("video name: \(v.properties["name"] as AnyObject)")
                print("video id: \(v.properties["id"] as AnyObject)")
                print("video thumbnail: \(v.properties["thumbnail"] as AnyObject)")
                print("video metadata: \(v.properties)")
                self.playbackController.setVideos([v] as NSArray)
            } else {
                print("ViewController Debug - Error retrieving video: \(error?.localizedDescription ?? "unknown error")")
            }
        }
    }

    func playbackController(_ controller: BCOVPlaybackController?, playbackSession session: BCOVPlaybackSession?, didReceive lifecycleEvent: BCOVPlaybackSessionLifecycleEvent?) {
        if (lifecycleEvent?.eventType == kBCOVPlaybackSessionLifecycleEventPlay) {
            print("ViewController Debug - Received lifecycle play event.")
        } else if (lifecycleEvent?.eventType == kBCOVPlaybackSessionLifecycleEventPause) {
            print("ViewController Debug - Received lifecycle pause event.")
        }
    }



    func playbackController(_ controller: BCOVPlaybackController!, didAdvanceTo session: BCOVPlaybackSession!) {
        print("Advanced to new session")
    }

    func playbackController(_ controller: BCOVPlaybackController!, playbackSession session: BCOVPlaybackSession!, didProgressTo progress: TimeInterval) {
        print("Progress: \(progress) seconds")
    }

    func playerView(_ playerView: BCOVPUIPlayerView?, willTransitionTo screenMode: BCOVPUIScreenMode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }

    func playerView(_ playerView: BCOVPUIPlayerView?, didTransitionTo screenMode: BCOVPUIScreenMode) {
        UIView.setAnimationsEnabled(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
    
    
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}



