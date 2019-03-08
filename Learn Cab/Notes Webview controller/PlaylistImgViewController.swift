//
//  PlaylistImgViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 22/03/18.
//  Copyright © 2018 Exarcplus. All rights reserved.
//

import UIKit
import SDWebImage
import SKPhotoBrowser
import ZoomImageView
class PlaylistImgViewController: UIViewController,UIWebViewDelegate,SKPhotoBrowserDelegate{
   
     @IBOutlet weak var imageView : ZoomImageView!
    var imgstr : String!
    var discription : String!
    var titlestr : String!
  @IBOutlet var detailswebviewheight : NSLayoutConstraint!
    @IBOutlet weak var detailswebview : UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titlestr
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        let catPictureURL = URL(string: imgstr)
        let data = try? Data(contentsOf: catPictureURL!)
        //imageView.zoomMode = .fill
        //imageView.backgroundColor = UIColor.black
        imageView.image = UIImage.init(data: data!)
        // imageView.addSubview(imageview)
//        let browser = SKPhotoBrowser(photos: self.createWebPhotos())
//        browser.initializePageIndex(0)
//        browser.delegate = self
//        self.present(browser, animated: true, completion: nil)
//        let vimage = imgstr
//        if vimage == ""
//        {
//            imageview.image = UIImage.init(named: "play_icon.png")
//        }
//        else
//        {
//            imageview.sd_setImage(with: URL(string: vimage!))
//        }
//
//
//        self.detailswebview.delegate = self
//        let font = UIFont.init(name: "Poppins-Light", size: 14)
//        detailswebview.scrollView.isScrollEnabled = true
//        detailswebview.backgroundColor = .clear
//        //self.webview.loadHTMLString("<span style=\"font-family: \(font!.fontName); font-size: \(font!.pointSize); \">\(discription)</span>", baseURL: nil)
//        self.detailswebview.loadHTMLString(discription, baseURL: nil)
//        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbutton(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imgbutton(_sender: UIButton)
    {
       
    }
//    DispatchQueue.global(qos: .background).async {
//    let image = self.imageFromVideo(url: url, at: 0)
//    
//    DispatchQueue.main.async {
//    self.imageView.image = image
//    }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension PlaylistImgViewController {
//    func didDismissAtPageIndex(_ index: Int) {
//    }
//    
//    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
//    }
//    
//    func removePhoto(index: Int, reload: (() -> Void)) {
//        SKCache.sharedCache.removeImageForKey("somekey")
//        reload()
//    }
//}
//
//private extension PlaylistImgViewController {
//    func createWebPhotos() -> [SKPhotoProtocol] {
//        return (0..<1).map { (i: Int) -> SKPhotoProtocol in
//            //            let photo = SKPhoto.photoWithImageURL("https://placehold.jp/150\(i)x150\(i).png", holder: UIImage(named: "image0.jpg")!)
//            print("hai")
//            
//            print(i)
//            //            let clickdetailsarr = imagedic.value(forKey: "gallery_image") as! String
//            let clickdetailsarr = imgstr
//            let photo = SKPhoto.photoWithImageURL(clickdetailsarr!)
//            //photo.caption = option[i%10]
//            photo.shouldCachePhotoURLImage = true
//            return photo
//        }
//    }
//}
//class CustomImageCache: SKImageCacheable {
//    var cache: SDImageCache
//    
//    init() {
//        let cache = SDImageCache(namespace: "com.suzuki.custom.cache")
//        self.cache = cache!
//    }
//    
//    func imageForKey(_ key: String) -> UIImage? {
//        guard let image = cache.imageFromDiskCache(forKey: key) else { return nil }
//        
//        return image
//    }
//    
//    func setImage(_ image: UIImage, forKey key: String) {
//        cache.store(image, forKey: key)
//    }
//    
//    func removeImageForKey(_ key: String) {
//    }
//}

