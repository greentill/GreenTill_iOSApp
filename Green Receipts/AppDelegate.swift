//
//  AppDelegate.swift
//  Green Receipts
//
//  Created by Mansur on 10/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var googleAccesTokenString: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        self.setLoginFlow()
        
        return true
    }

    
    //MARK: - Login & Root Navigation
    func setLoginFlow() {
        if (self.checkIfUserLogin())
        {
            self.setHomeViewNavBar()
        }
        else
        {
            self.setLoginViewNavBar()
        }
        self.window?.makeKeyAndVisible()
    }
    
    func checkIfUserLogin() -> Bool {
        let result = UserDefaultsManager.getUserLoggedInFlag()
        return result
    }
    
    func setLoginViewNavBar() {
        let initialNavigationController = self.getLoginNavBar()
        self.window?.rootViewController = initialNavigationController
    }
    func setHomeViewNavBar() {
        let initialNavigationController = self.getHomeNavBar()
        self.window?.rootViewController = initialNavigationController
    }
    
    func getLoginNavBar() -> UINavigationController {
        let mainView = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: mainView)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
    
    func getHomeNavBar() -> UINavigationController {
        let mainView = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: mainView)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        return GIDSignIn.sharedInstance().handle(url)
    }

}

extension AppDelegate : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            if UIApplication.topViewController() is LoginViewController
            {
                NotificationCenter.default.post(name: Notification.Name("GoogleSignInFail"), object: nil, userInfo: ["googleAccessToken":""])
            }
            return
        }
        
        guard let authentication = user.authentication else {
            if UIApplication.topViewController() is LoginViewController
            {
                NotificationCenter.default.post(name: Notification.Name("GoogleSignInFail"), object: nil, userInfo: ["googleAccessToken":""])
            }
            return
            
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        let tokenString = authentication.accessToken as String
        if UIApplication.topViewController() is LoginViewController
        {
            NotificationCenter.default.post(name: Notification.Name("GoogleSignInSuccess"), object: nil, userInfo: ["googleAccessToken":tokenString])
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

    }
    
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller:selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller:presented)
        }
        return controller
    }
}
