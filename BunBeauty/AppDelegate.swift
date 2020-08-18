//
//  AppDelegate.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 06/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        RepositoryContainer().setupContainer(using: AppDelegate.container)
        
        return true
    }
    
}

