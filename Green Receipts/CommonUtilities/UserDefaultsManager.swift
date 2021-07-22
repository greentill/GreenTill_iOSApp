//
//  UserDefaultsManager.swift
//  Green Receipts
//
//  Created by Mansur on 08/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class UserDefaultsManager: NSObject {
    
    //Mark: - UserLoggedin Flag
    
    class func saveUserLoggedInFlag(loggedIn:Bool)
    {
        self.saveBoolInDefaults(value: loggedIn, key: "isUserLogin")
    }
    
    class func getUserLoggedInFlag() -> Bool
    {
        let boolFlag: Bool = self.getBoolFormDefaults(key: "isUserLogin")
        return boolFlag
    }
 
    //Mark: - UserInformation
    
    class func saveUserInformationDictionary(dict:[String:Any])
    {
        self.saveDictionaryInDefaults(dict: dict, key: "UserInformation")
    }
    
    class func removeUserInformationDictionary()
    {
        self.removeDictionaryInDefaults(dict: nil, key: "UserInformation")
    }
    
    class func getUserInformationDictionary() -> [String:Any]?
    {
        let dict: [String:Any]? = self.getDictionaryFromDefaults(key: "UserInformation")
        return dict
    }
    
    //Mark: - Save Bool to UserDefaults
    
    class func saveBoolInDefaults(value: Bool, key: String)
    {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getBoolFormDefaults(key:String) -> Bool
    {
        var boolValue: Bool = false
        
        if isKeyPresentInUserDefaults(Key: key)
        {
            boolValue = UserDefaults.standard.bool(forKey: key)
        }
        
        return boolValue
    }
    
    //Mark: - Save Dictionary to UserDefaults
    
    class func saveDictionaryInDefaults(dict: [String:Any],key:String)
    {
        UserDefaults.standard.set(dict, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func removeDictionaryInDefaults(dict: [String:Any]?,key:String)
    {
        UserDefaults.standard.set(dict, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getDictionaryFromDefaults(key:String) -> [String:Any]?
    {
        var dict: [String:Any]? = nil
        if self.isKeyPresentInUserDefaults(Key: key)
        {
            dict = UserDefaults.standard.dictionary(forKey: key)
        }
        return dict
    }
    
    //Mark: - Common Method
    
    class func isKeyPresentInUserDefaults(Key:String) -> Bool
    {
        return UserDefaults.standard.object(forKey: Key) != nil
    }
}
