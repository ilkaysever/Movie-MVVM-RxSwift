//
//  AppDelegate.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let shared = UIApplication.shared.delegate as? AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        openSplashPage()
        return true
    }
    
    func openSplashPage() {
        let rootViewController = SplashScreen()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func openMainPage() {
        UIView.transition(with: window!, duration: 0.80, options: .transitionFlipFromRight, animations: {
            UIView.performWithoutAnimation {
                let vc = HomeViewController()
                let rootNav = BaseNavigationController(rootViewController: vc)
                if let window = self.window {
                    window.rootViewController = rootNav
                }
            }
        }, completion: nil)
    }

}
