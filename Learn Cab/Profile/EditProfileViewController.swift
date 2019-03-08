//
//  EditProfileViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 06/12/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import Alamofire
import KKActionSheet
import SKPhotoBrowser
import AFNetworking

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,SKPhotoBrowserDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, CropViewControllerDelegate {

    var myclass : MyClass!
    var passuserid : String!
    var tokenstr : String!
    var firstnamestr : String!
    var lastnamestr : String!
    var professionstr : String!
    var passwordstr : String!
    var mobilenostr : String!
    var username : String!
    var vimage = ""
    @IBOutlet weak var firstName : SkyFloatingLabelTextField!
    @IBOutlet weak var lastName : SkyFloatingLabelTextField!
    @IBOutlet weak var profession : SkyFloatingLabelTextField!
    @IBOutlet weak var mobileno : SkyFloatingLabelTextField!
    @IBOutlet weak var password : SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPwd : SkyFloatingLabelTextField!
    @IBOutlet weak var imgview : UIImageView!
     @IBOutlet weak var cameraview : UIImageView!
    var listarr = [Dictionary<String,AnyObject>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.title = "EDIT PROFILE"
        
        myclass = MyClass()
        tokenstr = UserDefaults.standard.string(forKey: "token")
        print(tokenstr)
        if UserDefaults.standard.value(forKey: "Logindetail") != nil{
            
            let result = UserDefaults.standard.value(forKey: "Logindetail")
            let newResult = result as! Dictionary<String,AnyObject>
            print(newResult)
            passuserid = newResult["id"] as! String
            print(passuserid)
            profession.text = newResult["profession"] as! String
            firstName.text = newResult["first_name"] as! String
            lastName.text = newResult["last_name"] as! String
            mobileno.text = newResult["mobile_no"] as! String
            username = newResult["username"] as! String
            vimage = newResult["profile_image"] as! String
            if vimage == ""
            {
                 imgview.image = UIImage.init(named: "Circle (1).png")
            }
            else
            {
                imgview.sd_setImage(with: URL(string: vimage))
            }
            cameraview.isHidden = false
        }
        //self.editlink()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backclick(_sender: UIButton)
    {
        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let nav = UINavigationController.init(rootViewController: mainview)
        self.present(nav, animated:true, completion: nil)
    }
    
    func editlink()
    {
        print(firstnamestr)
        print(lastnamestr)
        print(professionstr)
        print(mobilenostr)
        print(passwordstr)
        print(vimage)
        let params:[String:String] = ["token":tokenstr,"facultyId":passuserid,"first_name":firstnamestr,"last_name":lastnamestr,"username":username,"mobile_no":mobilenostr,"profession":professionstr,"profile_image":vimage,"password":""]
        // SVProgressHUD.show()
        Alamofire.request("https://manage.learncab.com/update_faculty_profile", method: .post, parameters: params).responseJSON { response in
            
            print(response)
            
            let result = response.result
            print(response)
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                
                let data = dict["data"] as? [Dictionary<String,AnyObject>]
                print(data)
                 let dat = dict["result"] as! String
                if dat == "success"
                {
//                 var userData = [Dictionary<String,AnyObject>]()
//                    userData.append(data!)
                    if let userData = data![0] as? Dictionary<String,AnyObject>{

                        print(userData)
                        UserDefaults.standard.set(userData, forKey: "Logindetail")
                        let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                        let nav = UINavigationController.init(rootViewController: mainview)
                        self.present(nav, animated:true, completion: nil)
                    }
                }
            }
       }
    }
    
    @IBAction func submitbutton(_ x:AnyObject)
    {
        firstnamestr = firstName.text
        lastnamestr = lastName.text
        professionstr = profession.text
        mobilenostr = mobileno.text
//        if password.text == "" && confirmPwd.text == ""
//        {
//            passwordstr = password.text
            self.editlink()
//        }
//        else
//        {
//
//        }
    }
    
    @IBAction func Addbutton(_ x:AnyObject)
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.showCamera()
        }
        actionSheet.addAction(cameraAction)
        let albumAction = UIAlertAction(title: "Photo Library", style: .default) { action in
            self.openPhotoAlbum()
        }
        actionSheet.addAction(albumAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func showCamera() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        present(controller, animated: true, completion: nil)
    }
    
    func openPhotoAlbum() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - CropView
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
        
    }
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        controller.dismiss(animated: true, completion: nil)
        self.UploadimageWithImage(image: image, size:CGSize(width: 200, height: 200))
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - UIImagePickerController delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        picker .dismiss(animated: true, completion: nil)
        
        let controller = CropViewController()
        controller.delegate = self
        controller.image = image
        
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    
    
    func UploadimageWithImage(image:UIImage,size:CGSize)
    {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newimage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let date=NSDate() as NSDate;
        let form = DateFormatter() as DateFormatter
        form.dateFormat="yyyy-MM-dd"
        let form1 = DateFormatter() as DateFormatter
        form1.dateFormat="HH:MM:SS"
        let datesstr = form.string(from: date as Date);
        let timestr = form1.string(from: date as Date);
        let datearr = datesstr.components(separatedBy: "-") as NSArray
        let timearr = timestr.components(separatedBy: ":") as NSArray
         let imageData = image.jpegData(compressionQuality: 0.75)
        let imagename = String(format:"pic_%@_%@_%@_%@_%@_%@.png",datearr.object(at: 0) as! String,datearr.object(at: 1) as! String,datearr.object(at: 2) as! String,timearr.object(at: 0) as! String,timearr.object(at: 1) as! String,timearr.object(at: 2) as! String)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "profilePicture", fileName: imagename, mimeType: "image/jpeg")
        }, to:"https://manage.learncab.com/upload_profile_piture")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                 
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        self.vimage = String(format:"https://manage.learncab.com/learncab/all_images/%@",imagename)
                        self.imgview.image = image
                      
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
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
