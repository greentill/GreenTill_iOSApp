//
//  ResetPasswordViewController.swift
//  Green Receipts
//
//  Created by Mansur on 19/06/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ResetPasswordViewController: BaseViewController {
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imgViewShowPassword: UIImageView!
    
    var isShowPassword: Bool = false
    var userData: UserLoginModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let backIcon = UIImage.init(named: "ic_BackArrow")
        let backButton = UIBarButtonItem(image: backIcon, style: .done, target: self, action: #selector(backClicked))
        backButton.tintColor = AppColor.appMainGreyColor
        self.navigationItem.leftBarButtonItem = backButton
        
        let lblTitle = UILabel()
        lblTitle.text = "Reset password"
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont(name: kAppRegularFont, size: 20.0)
        self.navigationItem.titleView = lblTitle
        
        self.txtPassword.placeholder = "Password"
        self.txtPassword.title = "Enter Password"
        self.txtPassword.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtPassword.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtPassword.tintColor = AppColor.appDarkPinkColor
        self.txtPassword.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtPassword.selectedLineColor = AppColor.appDarkPinkColor
        self.txtPassword.isSecureTextEntry = true
        
        if let imghidePass = UIImage(named: "ic_hide_password")
        {
            self.imgViewShowPassword.image = imghidePass
        }
        let showPasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPasswordType(tapGestureRecognizer:)))
        self.imgViewShowPassword.isUserInteractionEnabled = true
        self.imgViewShowPassword.addGestureRecognizer(showPasswordTapGestureRecognizer)
        
        self.btnSend.backgroundColor = AppColor.appGreenColor
        self.btnSend.setTitleColor(UIColor.white, for: .normal)
        self.btnSend.titleLabel?.font = UIFont(name: kAppBoldFont, size: 16)
        self.btnSend.titleLabel?.text = "Reset"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
           CommonUtility().addRoundCorners(view: self.btnSend, radius: AppRoundedTheme.roundedCornerRadiusForContainer)
    }
    
    // MARK: - Button Actions

    @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        self.view.endEditing(true)
        if (self.checkValidations()) {
            self.callServiceForUserSavePassword()
        }
    }


    // MARK: - Validations
    func checkValidations() -> Bool {
        
        let result = false
        var validationMessage : String!
        
       
        
        if self.checkNullValue(txtField: txtPassword)
        {
            validationMessage = "Please enter password"
        }
        else{
            return true
        }
        
        self.showAlertWithMessageWithTitle(title: "Reset Password", message: validationMessage)
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
    
    // MARK: - Service Call
    
    func callServiceForUserSavePassword(){
        
        if CommonUtility().isConnectedToNetwork() {
            
            if let token = self.userData?.irano,let email = self.userData?.email, let password = self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            {
                self.showHud("")
                WebserviceManager().requestSaveForgotPaswordOTP(email: email ,token:token, newPassword:password ) { (status, errorMessage) in
                    
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
