//
//  LoadingViewController.swift
//  Learn Cab
//
//  Created by Exarcplus on 30/11/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var imageView : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIView.animate(withDuration: 1, animations: {
//            self.imageView?.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }) { (finished) in
//            UIView.animate(withDuration: 1, animations: {
//                self.imageView?.transform = CGAffineTransform.identity
//            })
//        }
        var colors = [UIColor]()
        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        UIView.animate(withDuration: 0.1, animations: {() -> Void in
            self.imageView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        },completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 2.0, animations: {() -> Void in
                self.imageView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
        let dispatchTime3: DispatchTime = DispatchTime.now() + Double(Int64(3.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime3, execute: {
            self.Loadview()
//            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            let nav = UINavigationController.init(rootViewController: mainview)
//            self.present(nav, animated:true, completion: nil)
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Loadview()
    {
        if UserDefaults.standard.value(forKey: "Logindetail") == nil
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let nav = UINavigationController.init(rootViewController: mainview)
            self.present(nav, animated:true, completion: nil)
           
        }
        else
        {
            let mainview = kmainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let nav = UINavigationController.init(rootViewController: mainview)
            self.present(nav, animated:true, completion: nil)
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
