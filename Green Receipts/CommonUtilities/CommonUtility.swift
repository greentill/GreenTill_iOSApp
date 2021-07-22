//
//  CommonUtility.swift
//  Green Receipts
//
//  Created by Mansur on 11/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import SystemConfiguration

class CommonUtility: NSObject {
    
    func roundCornersWithWidth(view:UIView, radius: CGFloat, borderColor:UIColor, width:CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.borderWidth = width
        view.layer.borderColor = borderColor.cgColor
    }
    
    func addRoundCorners(view: UIView, radius:CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.clear.cgColor
    }
    func addShadowToView(view: UIView, ShadowColor:UIColor, ShadowOpacity: Float, shadowOffset: CGSize, ShadowRadius: CGFloat) {
        view.backgroundColor = UIColor.clear
        view.layer.shadowRadius = ShadowRadius
        view.layer.shadowOpacity = ShadowOpacity
        view.layer.shadowColor = ShadowColor.cgColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: ShadowRadius).cgPath
    }
    
    func addBottomShadowToView(view: UIView, ShadowColor:UIColor, ShadowOpacity: Float, shadowOffset: CGSize, ShadowRadius: CGFloat) {
        
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.red.cgColor
    }
    
    
    
    func addShadowToViewBounds(view: UIView, shadowColor: UIColor,ShadowOpacity: Float, shadowOffset: CGSize, ShadowRadius: CGFloat){
        view.layer.masksToBounds = false
        view.layer.shadowRadius = ShadowRadius
        view.layer.shadowOpacity = ShadowOpacity
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = shadowOffset
    }
    
    func addpaddingToLeftofTextField(textField: UITextField) {
        textField.leftViewMode = .always
        let leftContainerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftView = leftContainerView
        
    }
    
    func hasValue(object: AnyObject) -> Bool {
        
        if !(object is NSNull) {
            
            //Check for String Class
            if (object is String) {
                return true
            }
            
            //Check for NSString Class
            if (object is NSString) || (object is NSMutableString) {
                if object.length > 0 {
                    return true
                }
            }
            
            //Check for UIImage Class
            if (object is UIImage) {
                
                if object.cgImage! != nil {
                    return true
                }
            }
            
            //Check for Array Class
            if (object is [AnyObject]) {
                
                if object is [AnyObject] {
                    
                    let arr : [AnyObject] = object as! [AnyObject]
                    
                    if arr.count > 0 {
                        return true
                    }
                }
            } else {
                return true
                
            }
        }
        return false
    }
    
   class func getTokenOfLoggedInUser() -> String
    {
        var token: String = ""
        
        let dictUserInfo = UserDefaultsManager.getUserInformationDictionary()
        if let dictUserInformation = dictUserInfo
        {
            if let dicToken = dictUserInformation["irano"] as? String
            {
                token = dicToken
            }
        }
        
        return token
    }
    
    class func getEmailOfLoggedInUser() -> String
       {
           var token: String = ""
           
           let dictUserInfo = UserDefaultsManager.getUserInformationDictionary()
           if let dictUserInformation = dictUserInfo
           {
               if let dicToken = dictUserInformation["email"] as? String
               {
                   token = dicToken
               }
           }
           
           return token
       }
    
    func validateEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    //Mark: - Internet Connectivity Check Methods
    
    func isConnectedToNetwork()->Bool{

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret
    }
    
    func getCurrentDateInString() -> String {
        
        let dateFormatter:DateFormatter = DateFormatter.init()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString:String = dateFormatter.string(from: NSDate() as Date)
        return dateString
    }

}
extension UIViewController {
    
    func showHud(_ message: String) {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = message
            hud.tintColor = AppColor.appGreenColor
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func hideHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
        }
    }
}
