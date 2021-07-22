//
//  ChangePasswordViewController.swift
//  Green Receipts
//
//  Created by Mansur on 11/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class ChangePasswordViewController: BaseViewController {
    
    @IBOutlet weak var imgViewBack: UIImageView!
       @IBOutlet weak var lblChangePassword: UILabel!

    @IBOutlet weak var txtOldPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnConfirmPassword: UIButton!
    @IBOutlet weak var imgViewShowOldPassword: UIImageView!
    @IBOutlet weak var imgViewShowPassword: UIImageView!
    @IBOutlet weak var imgViewShowConfirmPassword: UIImageView!
    
    var isShowPassword: Bool = false
    var isShowOldPassword: Bool = false
    var isShowConfirmPassword: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backClicked(tapGestureRecognizer:)))
        self.imgViewBack.isUserInteractionEnabled = true
        self.imgViewBack.addGestureRecognizer(backButtonTapGestureRecognizer)
        if let imgCamera = UIImage(named: "ic_BackArrow")
        {
            self.imgViewBack.image = imgCamera.withRenderingMode(.alwaysTemplate)
            self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        
        self.lblChangePassword.text = "Change password"
        lblChangePassword.textColor = AppColor.appMainGreyColor
        lblChangePassword.font = UIFont(name: kAppBoldFont, size: 20.0)
        
        self.txtOldPassword.placeholder = "Old Password"
        self.txtOldPassword.title = "Old Password"
        self.txtOldPassword.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtOldPassword.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtOldPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtOldPassword.tintColor = AppColor.appDarkPinkColor
        self.txtOldPassword.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtOldPassword.selectedLineColor = AppColor.appDarkPinkColor
        self.txtOldPassword.isSecureTextEntry = true
        
        self.txtPassword.placeholder = "New Password"
        self.txtPassword.title = "New Password"
        self.txtPassword.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtPassword.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtPassword.tintColor = AppColor.appDarkPinkColor
        self.txtPassword.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtPassword.selectedLineColor = AppColor.appDarkPinkColor
        self.txtPassword.isSecureTextEntry = true
        
        self.txtConfirmPassword.placeholder = "Re-enter New Password"
        self.txtConfirmPassword.title = "Re-enter New Password"
        self.txtConfirmPassword.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtConfirmPassword.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtConfirmPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtConfirmPassword.tintColor = AppColor.appDarkPinkColor
        self.txtConfirmPassword.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtConfirmPassword.selectedLineColor = AppColor.appDarkPinkColor
        self.txtConfirmPassword.isSecureTextEntry = true
        
        self.btnConfirmPassword.backgroundColor = AppColor.appGreenColor
        self.btnConfirmPassword.setTitle("Confirm Password", for: .normal)
        self.btnConfirmPassword.setTitleColor(UIColor.white, for: .normal)
        self.btnConfirmPassword.titleLabel?.font = UIFont(name: kAppBoldFont, size: 16)
        
        if let imghidePass = UIImage(named: "ic_hide_password")
        {
            self.imgViewShowPassword.image = imghidePass
            self.imgViewShowOldPassword.image = imghidePass
            self.imgViewShowConfirmPassword.image = imghidePass
        }
        let showPasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPasswordType(tapGestureRecognizer:)))
        self.imgViewShowPassword.isUserInteractionEnabled = true
        self.imgViewShowPassword.addGestureRecognizer(showPasswordTapGestureRecognizer)
        
        let showOldPasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showOldPasswordType(tapGestureRecognizer:)))
        self.imgViewShowOldPassword.isUserInteractionEnabled = true
        self.imgViewShowOldPassword.addGestureRecognizer(showOldPasswordTapGestureRecognizer)
        
        let showConfirmPasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showConfirmPasswordType(tapGestureRecognizer:)))
        self.imgViewShowConfirmPassword.isUserInteractionEnabled = true
        self.imgViewShowConfirmPassword.addGestureRecognizer(showConfirmPasswordTapGestureRecognizer)
        
    }
    
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        CommonUtility().addRoundCorners(view: self.btnConfirmPassword, radius: 25)
    }

    // MARK: - Button Actions

    @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Validations
    func checkValidations() -> Bool {
        
        let result = false
        var validationMessage : String!
        
       
        
        if self.checkNullValue(txtField: txtOldPassword)
        {
            validationMessage = "Please enter Old Password"
        }
        else if self.checkNullValue(txtField: txtPassword)
        {
            validationMessage = "Please enter password"
        }
        else if self.checkNullValue(txtField: txtConfirmPassword)
        {
            validationMessage = "Please confirm password"
        }
        else{
            return true
        }
        
        self.showAlertWithMessageWithTitle(title: "Change Password", message: validationMessage)
        return result
    }
    
    func checkNullValue(txtField: UITextField) -> Bool {
        
        if let txtFieldValue = txtField.text
        {
            let str: String = txtFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if(str == "")
            {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    @IBAction func btnConfirmPasswordClicked(_ sender: Any) {
        self.view.endEditing(true)
        if (self.checkValidations()) {
            self.callServiceForUserChangePassword()
        }
    }
    
    // MARK: - Supporting Methods
    func gotoLoginScren(){
        DispatchQueue.main.async {
            UserDefaultsManager.saveUserLoggedInFlag(loggedIn: false)
            UserDefaultsManager.removeUserInformationDictionary()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setLoginViewNavBar()
        }
    }
    
    @objc func showPasswordType(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if !isShowPassword
        {
            self.isShowPassword = true
            if let imgCheck = UIImage(named: "ic_show_password")
            {
                self.imgViewShowPassword.image = imgCheck
                
            }
            self.txtPassword.isSecureTextEntry = false
        }
        else{
            self.isShowPassword = false
            if let imgCheck = UIImage(named: "ic_hide_password")
            {
                self.imgViewShowPassword.image = imgCheck
                
            }
            self.txtPassword.isSecureTextEntry = true
        }
    }
    
    @objc func showOldPasswordType(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if !isShowOldPassword
        {
            self.isShowOldPassword = true
            if let imgCheck = UIImage(named: "ic_show_password")
            {
                self.imgViewShowOldPassword.image = imgCheck
               
            }
            self.txtOldPassword.isSecureTextEntry = false
        }
        else{
            self.isShowOldPassword = false
            if let imgCheck = UIImage(named: "ic_hide_password")
            {
                self.imgViewShowOldPassword.image = imgCheck
            }
            self.txtOldPassword.isSecureTextEntry = true
        }
    }
    
    @objc func showConfirmPasswordType(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if !isShowConfirmPassword
        {
            self.isShowConfirmPassword = true
            if let imgCheck = UIImage(named: "ic_show_password")
            {
                self.imgViewShowConfirmPassword.image = imgCheck
               
            }
            self.txtConfirmPassword.isSecureTextEntry = false
        }
        else{
            self.isShowConfirmPassword = false
            if let imgCheck = UIImage(named: "ic_hide_password")
            {
                self.imgViewShowConfirmPassword.image = imgCheck
            }
            self.txtConfirmPassword.isSecureTextEntry = true
        }
    }
    
    // MARK: - Service Call
    
    func callServiceForUserChangePassword(){
        
        if CommonUtility().isConnectedToNetwork() {
            let token = CommonUtility.getTokenOfLoggedInUser()
            let email = CommonUtility.getEmailOfLoggedInUser()
            
            if let oldPassword = self.txtOldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines),token != ""
            {
                self.showHud("")
                WebserviceManager().changeUserPassword(token: token,oldPassword: oldPassword ,newPassword:password,email:email ) { (status, errorMessage) in
                    
                    if (status == true)
                    {
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Password update succesfully"
                        }
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithCompletion(title: "Change Password", message: errorMsg, completion: {
                                self.gotoLoginScren()
                            })
                        }
                    }
                    else{
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithTitle(title: "Change Password", message: errorMsg)
                        }
                    }
                    
                    self.hideHud()
                }
                
            } else {
                
            }
        } else
        {
            let errorMSg = "Internet connection seems to be offline. Please check your internet connection"
            self.showAlertWithMessageWithTitle(title: "Internet Connection", message: errorMSg)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
