//
//  AppDelegate.swift
//  SpiderTestApp
//
//  Created by Антон on 16.07.2018.
//  Copyright © 2018 Anton Trofimov. All rights reserved.
//

import UIKit
import ImgurSession

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    let imgurSessionClientId = "e075f33d48edcd7"
    
    let imgurSessionClientSecret = "be34a7063c301edd3a72f4e630c8aee6b1a49e2f"
    
    var imgurCompletion: (() -> Void)?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        IMGSession.anonymousSession(withClientID: imgurSessionClientId, with: self)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        imgurCompletion?()
        return true
    }

}

extension AppDelegate: IMGSessionDelegate {

    func imgurSessionNeedsExternalWebview(_ url: URL!, completion: (() -> Void)!) {
        self.imgurCompletion = completion
        UIApplication.shared.open(url)
    }

}

