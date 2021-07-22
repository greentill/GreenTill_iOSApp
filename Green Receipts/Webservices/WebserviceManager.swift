//
//  WebserviceManager.swift
//  Green Receipts
//
//  Created by Mansur on 01/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class WebserviceManager: NSObject {
    
    typealias loginCallback = (UserLoginModel?,Bool,String) -> Void
    typealias forgotPasswordOTPCallback = (UserLoginModel?,Bool,String) -> Void
    typealias registerCallback = (RegisterUserModel?,Bool,String) -> Void
    typealias userProfileCallback = (UserProfileModel?,Bool,String) -> Void
    typealias upateUserProfileCallback = (Bool,String) -> Void
    typealias changeUserPasswordCallback = (Bool,String) -> Void
    typealias resetUserPasswordCallback = (Bool,String) -> Void
    typealias userBillCallback = ([UserBillModel],Bool,String,Int) -> Void
    typealias userLatestBillCallback = ([UserLatestBillModel]?,Bool,String,Int) -> Void
    typealias getUserBillByShopCallback = ([UserLatestBillModel]?,Bool,String,Int) -> Void
    typealias getCameraUploadCallback = ([UserCameraUploadedBillModel]?,Bool,String) -> Void
    typealias uploadCameraImageCallback = (Bool,String) -> Void
    typealias getQRDataCallback = (QRInfoDataModel?,Bool,String) -> Void
    typealias saveQRDataCallback = (QRInfoDataModel?,Bool,String) -> Void
    typealias getGoogleDataCallback = ([String: AnyObject]?,Bool,String) -> Void
    
    //MARK: - Login Service Methods
    
    func loginAuthenticateUser(userName: String, password:String, OnCompletion:@escaping loginCallback) {
        
        let parameters: [String:String] = [
            "username": userName,
            "password": password
        ]
        
        let url = kAppBaseURL + "userLogin.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let userLogindata: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                if let userLoginModelObject = userLogindata.first
                                {
                                    var dataPreference = userLoginModelObject as Dictionary<String,Any>
                                    for key in dataPreference.keys
                                    {
                                        if(!CommonUtility().hasValue(object: dataPreference[key] as AnyObject))
                                        {
                                            dataPreference[key] = ""
                                        }
                                    }
                                    UserDefaultsManager.saveUserInformationDictionary(dict: dataPreference)
                                    
                                    let userLoginModel: UserLoginModel = UserLoginModel.init(fromDictionary: userLoginModelObject)
                                    
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(userLoginModel,true,result)
                                    } else {
                                        OnCompletion(userLoginModel,true,"")
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result)
                            }
                            else {
                                OnCompletion(nil,false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    func requestForgotPaswordOTP(email: String,otpString:String, OnCompletion:@escaping forgotPasswordOTPCallback) {
        
        let parameters: [String:String] = [
            "email_id": email,
            "param": "checkUserSendEmailOTP",
            "text_otp": otpString
        ]
        
        let url = kAppBaseURL + "forgotPassword.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let userLogindata: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                if let userLoginModelObject = userLogindata.first
                                {
                                    let userLoginModel: UserLoginModel = UserLoginModel.init(fromDictionary: userLoginModelObject)
                                    
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(userLoginModel,true,result)
                                    } else {
                                        OnCompletion(userLoginModel,true,"")
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result)
                            }
                            else {
                                OnCompletion(nil,false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    func requestSaveForgotPaswordOTP(email: String, token:String,newPassword:String, OnCompletion:@escaping resetUserPasswordCallback) {
        
        let parameters: [String:String] = [
            "email_id": email,
            "param": "forgotPasswordSave",
            "token": token,
            "new_pswd": newPassword
        ]
        
        let url = kAppBaseURL + "forgotPassword.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(true,result)
                            } else {
                                OnCompletion(true,"")
                            }
                            
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(false,result)
                            }
                            else {
                                OnCompletion(false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(false,"")
                    }
                }
                else
                {
                    OnCompletion(false,"")
                }
            }
            else {
                OnCompletion(false,"")
            }
        })
    }
    
    //MARK: - Register User Service Methods
    
    func registerNewUser(emailId: String, password:String,firstName: String,lastName: String,mobileNo:String,countyId:String,countyName:String,isFromSocialLogIn:Bool ,OnCompletion:@escaping registerCallback) {
        
        let parameters: [String:String] = [
            "email_id": emailId,
            "firstname": firstName,
            "lastname": lastName,
            "mobileno": mobileNo,
            "password": password,
            "countyid": countyId,
            "countyname": countyName
        ]
        
        let url = kAppBaseURL + "userRegister.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let userLogindata: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                if let userRegistrationModelObject = userLogindata.first
                                {
                                    var dataPreference = userRegistrationModelObject as Dictionary<String,Any>
                                    for key in dataPreference.keys
                                    {
                                        if(!CommonUtility().hasValue(object: dataPreference[key] as AnyObject))
                                        {
                                            dataPreference[key] = ""
                                        }
                                    }
                                    UserDefaultsManager.saveUserInformationDictionary(dict: dataPreference)
                                    let userRegisterModel: RegisterUserModel = RegisterUserModel.init(fromDictionary: userRegistrationModelObject)
                                    
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(userRegisterModel,true,result)
                                    } else {
                                        OnCompletion(userRegisterModel,true,"")
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            
                            if isFromSocialLogIn
                            {
                                if let userLogindata: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                                {
                                    if let userRegistrationModelObject = userLogindata.first
                                    {
                                        var dataPreference = userRegistrationModelObject as Dictionary<String,Any>
                                        for key in dataPreference.keys
                                        {
                                            if(!CommonUtility().hasValue(object: dataPreference[key] as AnyObject))
                                            {
                                                dataPreference[key] = ""
                                            }
                                        }
                                        UserDefaultsManager.saveUserInformationDictionary(dict: dataPreference)
                                        let userRegisterModel: RegisterUserModel = RegisterUserModel.init(fromDictionary: userRegistrationModelObject)
                                        
                                        if let result: String = dictResponseUnwrapped["result"] as? String
                                        {
                                            OnCompletion(userRegisterModel,true,result)
                                        } else {
                                            OnCompletion(userRegisterModel,true,"")
                                        }
                                    }
                                    else
                                    {
                                        if let result: String = dictResponseUnwrapped["result"] as? String
                                        {
                                            OnCompletion(nil,false,result)
                                        }
                                        else {
                                            OnCompletion(nil,false,"")
                                        }
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }

                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    //MARK: - User Profile Service Methods
    
    func getUserProfile(token: String,OnCompletion:@escaping userProfileCallback) {
        
        let parameters: [String:String] = [
            "token": token,
            "param": "getProfile"
        ]
        
        let url = kAppBaseURL + "profile_information.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let userProfiledata: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                if let userProfileModelObject = userProfiledata.first
                                {
                                    var dataPreference = userProfileModelObject as Dictionary<String,Any>
                                    for key in dataPreference.keys
                                    {
                                        if(!CommonUtility().hasValue(object: dataPreference[key] as AnyObject))
                                        {
                                            dataPreference[key] = ""
                                        }
                                    }
                                    //UserDefaultsManager.saveUserInformationDictionary(dict: dataPreference)
                                    let userProfileModel: UserProfileModel = UserProfileModel.init(fromDictionary: userProfileModelObject)
                                    
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(userProfileModel,true,result)
                                    } else {
                                        OnCompletion(userProfileModel,true,"")
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result)
                            }
                            else {
                                OnCompletion(nil,false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    func updateUserProfile(token: String,firstName: String,lastName: String,mobileNo: String,email: String,OnCompletion:@escaping upateUserProfileCallback) {
        
        let parameters: [String:String] = [
            "token": token,
            "param": "updateProfile",
            "firstname":firstName,
            "lastname": lastName,
            "mobileno": mobileNo,
            "email": email
        ]
        
        let url = kAppBaseURL + "profile_information.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(true,result)
                            } else {
                                OnCompletion(true,"")
                            }
                            
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(false,result)
                            }
                            else {
                                OnCompletion(false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(false,"")
                    }
                }
                else
                {
                    OnCompletion(false,"")
                }
            }
            else {
                OnCompletion(false,"")
            }
        })
    }
    
    func changeUserPassword(token: String,oldPassword: String,newPassword: String,email: String,OnCompletion:@escaping changeUserPasswordCallback) {
        
        let parameters: [String:String] = [
            "token": token,
            "param": "changePassword",
            "email":email,
            "old_pswd": oldPassword,
            "new_pswd": newPassword
        ]
        
        let url = kAppBaseURL + "profile_information.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(true,result)
                            } else {
                                OnCompletion(true,"")
                            }
                            
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(false,result)
                            }
                            else {
                                OnCompletion(false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(false,"")
                    }
                }
                else
                {
                    OnCompletion(false,"")
                }
            }
            else {
                OnCompletion(false,"")
            }
        })
    }

    //MARK: - User Bill Service Methods
    
    func getUserBill(token: String,OnCompletion:@escaping userBillCallback) {
        
        var userBillList: [UserBillModel] = []
        let parameters: [String:String] = [
            "token": token
        ]
        
        let url = kAppBaseURL + "getUserBill.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let userBillObject: [[String : Any]] = dictResponseUnwrapped["data"] as? [[String: Any]]
                            {
                                for userbillData in userBillObject
                                {
                                    let userBillModel: UserBillModel = UserBillModel.init(fromDictionary: userbillData)
                                    userBillList.append(userBillModel)
                                }
                                
                                var records = 0
                                if let totalRecords: Int = dictResponseUnwrapped["records"] as? Int
                                {
                                    records = totalRecords
                                }
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(userBillList,true,result,records)
                                } else {
                                    OnCompletion(userBillList,true,"",records)
                                }
                                
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(userBillList,false,result,0)
                                }
                                else {
                                    OnCompletion(userBillList,false,"",0)
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(userBillList,false,result,0)
                            }
                            else {
                                OnCompletion(userBillList,false,"",0)
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(userBillList,false,"",0)
                    }
                }
                else
                {
                    OnCompletion(userBillList,false,"",0)
                }
            }
            else {
                OnCompletion(userBillList,false,"",0)
            }
        })
    }
    
    func getUserLatestBill(token: String,OnCompletion:@escaping userLatestBillCallback) {
        
        
        let parameters: [String:String] = [
            "token": token
        ]
        
        let url = kAppBaseURL + "getUserLatestBill.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            var userLatestBillList: [UserLatestBillModel] = [UserLatestBillModel]()
                            if let userBillObject: [[String : Any]] = dictResponseUnwrapped["data"] as? [[String: Any]]
                            {
                                for userbillData in userBillObject
                                {
                                    let userLaestBillModel: UserLatestBillModel = UserLatestBillModel.init(fromDictionary: userbillData)
                                    userLatestBillList.append(userLaestBillModel)
                                }
                                
                                var records = 0
                                if let totalRecords: Int = dictResponseUnwrapped["records"] as? Int
                                {
                                    records = totalRecords
                                }
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(userLatestBillList,true,result,records)
                                } else {
                                    OnCompletion(userLatestBillList,true,"",records)
                                }
                                
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result,0)
                                }
                                else {
                                    OnCompletion(nil,false,"",0)
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result,0)
                            }
                            else {
                                OnCompletion(nil,false,"",0)
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"",0)
                    }
                }
                else
                {
                    OnCompletion(nil,false,"",0)
                }
            }
            else {
                OnCompletion(nil,false,"",0)
            }
        })
    }
    
    func getUserBillByShop(token: String,store:String,OnCompletion:@escaping getUserBillByShopCallback) {
        
        
        let parameters: [String:String] = [
            "token": token,
            "bill_store": store
        ]
        
        let url = kAppBaseURL + "getUserBillByShop.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            var userLatestBillList: [UserLatestBillModel] = [UserLatestBillModel]()
                            if let userBillObject: [[String : Any]] = dictResponseUnwrapped["data"] as? [[String: Any]]
                            {
                                for userbillData in userBillObject
                                {
                                    let userLaestBillModel: UserLatestBillModel = UserLatestBillModel.init(fromDictionary: userbillData)
                                    userLatestBillList.append(userLaestBillModel)
                                }
                                
                                var records = 0
                                if let totalRecords: Int = dictResponseUnwrapped["records"] as? Int
                                {
                                    records = totalRecords
                                }
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(userLatestBillList,true,result,records)
                                } else {
                                    OnCompletion(userLatestBillList,true,"",records)
                                }
                                
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result,0)
                                }
                                else {
                                    OnCompletion(nil,false,"",0)
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result,0)
                            }
                            else {
                                OnCompletion(nil,false,"",0)
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"",0)
                    }
                }
                else
                {
                    OnCompletion(nil,false,"",0)
                }
            }
            else {
                OnCompletion(nil,false,"",0)
            }
        })
    }
    
    //MARK: - User Camera upload Bill Service Methods
    
    func getCameraUplods(token: String,OnCompletion:@escaping getCameraUploadCallback) {
        
        let parameters: [String:String] = [
            "token": token,
            "param": "getUploadedBill"
        ]
        
        let url = kAppBaseURL + "cameraUploadGet.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            var cameraUploadList: [UserCameraUploadedBillModel] = [UserCameraUploadedBillModel]()
                            if let cameraUploadObject: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                for userbillData in cameraUploadObject
                                {
                                    let userCameraUploadBillModel: UserCameraUploadedBillModel = UserCameraUploadedBillModel.init(fromDictionary: userbillData)
                                    cameraUploadList.append(userCameraUploadBillModel)
                                }
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(cameraUploadList,true,result)
                                } else {
                                    OnCompletion(cameraUploadList,true,"")
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result)
                            }
                            else {
                                OnCompletion(nil,false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    func uploadCameraImage(token: String,billTimeStamp:String,imgData: Data,OnCompletion:@escaping uploadCameraImageCallback) {
        
        let parameters: [String:String] = [
            "token": token,
            "bill_timestamp": billTimeStamp,
            "param": "uploadBill"
        ]
        
        let url = kAppBaseURL + "cameraUpload.php"
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(true,result)
                            }
                            else {
                                OnCompletion(true,"")
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(false,result)
                            }
                            else {
                                OnCompletion(false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(false,"")
                    }
                }
                else
                {
                    OnCompletion(false,"")
                }
            }
            else {
                OnCompletion(false,"")
            }
        })
    }
    
    //MARK: - User QR Bill Service Methods
    
    func getQRData(token: String, qrString:String, OnCompletion:@escaping getQRDataCallback) {
        let uuid = UUID().uuidString
        let parameters: [String:String] = [
            "token": token,
            "appid": uuid,
            "qrScann": qrString
        ]
        
        let url = kAppBaseURL + "getQrData.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let qrData: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                if let qrDataModelObject = qrData.first
                                {
                                    let qrDataModel: QRInfoDataModel = QRInfoDataModel.init(fromDictionary: qrDataModelObject)
                                    
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(qrDataModel,true,result)
                                    } else {
                                        OnCompletion(qrDataModel,true,"")
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result)
                            }
                            else {
                                OnCompletion(nil,false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    func saveQRData(token: String, qrString:String, OnCompletion:@escaping saveQRDataCallback) {
        let uuid = UUID().uuidString
        let parameters: [String:String] = [
            "token": token,
            "appid": uuid,
            "qrScann": qrString
        ]
        
        let url = kAppBaseURL + "saveUserBill.php"
        let imgData = Data()
        ServiceFactory().multipartRequest(serviceURL: url, parameters: parameters, imgData: imgData, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    if let status: String = dictResponseUnwrapped["status"] as? String
                    {
                        if status == "S"
                        {
                            if let qrData: [[String : AnyObject]] = dictResponseUnwrapped["data"] as? [[String: AnyObject]]
                            {
                                if let qrDataModelObject = qrData.first
                                {
                                    let qrDataModel: QRInfoDataModel = QRInfoDataModel.init(fromDictionary: qrDataModelObject)
                                    
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(qrDataModel,true,result)
                                    } else {
                                        OnCompletion(qrDataModel,true,"")
                                    }
                                }
                                else
                                {
                                    if let result: String = dictResponseUnwrapped["result"] as? String
                                    {
                                        OnCompletion(nil,false,result)
                                    }
                                    else {
                                        OnCompletion(nil,false,"")
                                    }
                                }
                            }
                            else
                            {
                                if let result: String = dictResponseUnwrapped["result"] as? String
                                {
                                    OnCompletion(nil,false,result)
                                }
                                else {
                                    OnCompletion(nil,false,"")
                                }
                            }
                        }
                        else {
                            if let result: String = dictResponseUnwrapped["result"] as? String
                            {
                                OnCompletion(nil,false,result)
                            }
                            else {
                                OnCompletion(nil,false,"")
                            }
                        }
                    }
                    else
                    {
                        OnCompletion(nil,false,"")
                    }
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
    func getGoogelData(accessToken: String, OnCompletion:@escaping getGoogleDataCallback) {
        
        let url = kGoogleInfoURl + accessToken
        
        ServiceFactory().callGetWithURL(strURL: url, parameters: nil, callBack: { (responseDetails,error,successStatus) in
            
            if (successStatus)
            {
                let dictResponse: [String: AnyObject]? = responseDetails as? [String: AnyObject]
                
                if let dictResponseUnwrapped = dictResponse
                {
                    OnCompletion(dictResponseUnwrapped,true,"")
                }
                else
                {
                    OnCompletion(nil,false,"")
                }
            }
            else {
                OnCompletion(nil,false,"")
            }
        })
    }
    
}
