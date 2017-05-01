//
//  AppDelegate.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit
import CoreData
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        #if arch(i386) || arch(x86_64)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            print("\n\n Document Path: \(documentsPath) \n\n")
        #endif
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        window.rootViewController =  MainAssembler.mainStoryBoard.instantiateInitialViewController()
        
        return true
    }

}

