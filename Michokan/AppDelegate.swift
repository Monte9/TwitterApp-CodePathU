//
//  AppDelegate.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/6/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
      //  window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
//        // Set up the search View Controller
//        let tweetsNavigationController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController
//        let tweetsViewController = tweetsNavigationController.topViewController as! TweetsViewController
//        tweetsNavigationController.tabBarItem.title = "Home"
//        tweetsNavigationController.tabBarItem.image = UIImage(named: "home")
//        
//        
//        //Customize Popular navigation bar UI
//        tweetsNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(rgba: "#55acee").CGColor]
//        
//        /* Create an Image View to replace the Title View */
//        var imageView: UIImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 40.0, 40.0))
//        
//        imageView.contentMode = UIViewContentMode.ScaleAspectFit
//        
//        /* Load an image. Be careful, this image will be cached */
//        var image: UIImage = UIImage(named: "Icon-Small-50")!
//        
//        /* Set the image of the Image View */
//        imageView.image = image
//        
//        /* Set the Title View */
//        tweetsNavigationController.navigationBar.topItem?.titleView = imageView
//        
//        
//        
//        
//        // Set up the search View Controller
//        let meNavigationController = storyboard.instantiateViewControllerWithIdentifier("MeNavigationController") as! UINavigationController
//        let meViewController = meNavigationController.topViewController
//        meNavigationController.tabBarItem.title = "Me"
//        meNavigationController.tabBarItem.image = UIImage(named: "me")
//        
//        
////        //Customize Popular navigation bar UI
////        nearbyNavigationController.navigationBar.barTintColor = UIColor(red: 218/255, green: 56/255, blue: 40/255, alpha: 1)
////        nearbyNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
////        nearbyNavigationController.navigationBar.topItem?.title = "Nearby"
//        
//        // Set up the Tab Bar Controller to have two tabs
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [tweetsNavigationController, meNavigationController]
//       // UITabBar.appearance().tintColor = UIColor(red: 218/255, green: 56/255, blue: 40/255, alpha: 1)
//        //    UITabBar.appearance().barTintColor = UIColor.blackColor()
//        
        
//        // Make the Tab Bar Controller the root view controller
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
//        
//        if (User.currentUser != nil) {
//            // GO to the logged in screen
//            print("Current User detected")
//            
//            var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as? UIViewController
//            window?.rootViewController = vc           
//        }
//        
        return true
    }
    
    func userDidLogout() {
        var vc = storyboard.instantiateViewControllerWithIdentifier("ViewController") as? UIViewController
        window?.rootViewController = vc
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        TwitterClient.sharedInstance.openUrl(url)
        
        return true
    }
}

