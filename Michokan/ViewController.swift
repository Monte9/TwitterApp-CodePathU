//
//  ViewController.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/6/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import UIColor_Hex_Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customView = UIView(frame: CGRectMake(0.0, 0.0, customView.frame.width, customView.frame.height))
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(rgba: "#00ffcc").CGColor, UIColor(rgba: "#55acee").CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if(user != nil) {
                //perform segue
               
                self.appDelegate.setupTabBars()
                
              //  self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                //handle login error
            }
            
        }
    }
        
}

