//
//  RegistrationViewController.swift
//  Green Receipts
//
//  Created by Mansur on 21/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import SKCountryPicker
import IQKeyboardManager

class RegistrationViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgViewLogo: UIImageView!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var shadowEmailContainerView: UIView!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var imgViewEmail: UIImageView!
    @IBOutlet weak var txtEmail: CustomTextField!
  
    @IBOutlet weak var shadowFirstNameContainerView: UIView!
    @IBOutlet weak var firstNameContainerView: UIView!
    @IBOutlet weak var imgViewFirstName: UIImageView!
    @IBOutlet weak var txtFirstName: CustomTextField!
    
    @IBOutlet weak var shadowLastNameContainerView: UIView!
    @IBOutlet weak var lastNameContainerView: UIView!
    @IBOutlet weak var imgViewLastName: UIImageView!
    @IBOutlet weak var txtLastName: CustomTextField!
    
    @IBOutlet weak var shadowPasswordContainerView: UIView!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var imgViewPassword: UIImageView!
    @IBOutlet weak var txtPassword: CustomTextField!
    
    @IBOutlet weak var shadowConfirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordContainerView: UIView!
    @IBOutlet weak var imgViewConfirmPassword: UIImageView!
    @IBOutlet weak var txtConfirmPassword: CustomTextField!
    
    @IBOutlet weak var shadowMobileContainerView: UIView!
    @IBOutlet weak var mobileContainerView: UIView!
    @IBOutlet weak var imgViewMobile: UIImageView!
    @IBOutlet weak var txtMobile: CustomTextField!
    
    @IBOutlet weak var shadowCountryContainerView: UIView!
    @IBOutlet weak var countryContainerView: UIView!
    @IBOutlet weak var imgViewCountry: UIImageView!
    @IBOutlet weak var txtCountry: CustomTextField!
    
    var selectedCounrtyName:String = ""
    var selectedCounrtyId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let imgLogo = UIImage(named: "logoo")
        {
            self.imgViewLogo.image = imgLogo
        }
        
        
        self.btnRegister.backgroundColor = AppColor.appGreenColor
        self.btnRegister.setTitleColor(UIColor.white, for: .normal)
        self.btnRegister.titleLabel?.font = UIFont(name: kAppBoldFont, size: 16)
        self.btnRegister.titleLabel?.text = "Register"
        
        let backIcon = UIImage.init(named: "ic_BackArrow")
        let backButton = UIBarButtonItem(image: backIcon, style: .done, target: self, action: #selector(backClicked))
        backButton.tintColor = AppColor.appMainGreyColor
        self.navigationItem.leftBarButtonItem = backButton
        
        let lblTitle = UILabel()
        lblTitle.text = "Create an Account"
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont(name: kAppRegularFont, size: 17.0)
        self.navigationItem.titleView = lblTitle
        
        CommonUtility().addpaddingToLeftofTextField(textField: txtEmail)
        CommonUtility().addpaddingToLeftofTextField(textField: txtFirstName)
        CommonUtility().addpaddingToLeftofTextField(textField: txtLastName)
        CommonUtility().addpaddingToLeftofTextField(textField: txtPassword)
        CommonUtility().addpaddingToLeftofTextField(textField: txtConfirmPassword)
        CommonUtility().addpaddingToLeftofTextField(textField: txtMobile)
        CommonUtility().addpaddingToLeftofTextField(textField: txtCountry)
        
        //Email
        if let imgEmail = UIImage(named: "ic_EmailAddress")
        {
            self.imgViewEmail.image = imgEmail.withRenderingMode(.alwaysTemplate)
            self.imgViewEmail.tintColor = AppColor.appRedColor
        }
        self.txtEmail.attributedPlaceholder = NSAttributedString.init(string: "Email", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtEmail.tintColor = AppColor.appDarkPinkColor
        self.txtEmail.font = UIFont(name: kAppRegularFont, size: 16.0)
        //First Name
        
        if let imgPleople = UIImage(named: "ic_People")
        {
            self.imgViewFirstName.image = imgPleople.withRenderingMode(.alwaysTemplate)
            self.imgViewFirstName.tintColor = AppColor.appMainGreyColor
        }
         self.txtFirstName.attributedPlaceholder = NSAttributedString.init(string: "First Name", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtFirstName.tintColor = AppColor.appDarkPinkColor
        self.txtFirstName.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        //Last Name
        if let imgPleople = UIImage(named: "ic_People")
        {
            self.imgViewLastName.image = imgPleople.withRenderingMode(.alwaysTemplate)
            self.imgViewLastName.tintColor = AppColor.appMainGreyColor
        }
        
        self.txtLastName.attributedPlaceholder = NSAttributedString.init(string: "Last Name", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtLastName.tintColor = AppColor.appDarkPinkColor
        self.txtLastName.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        //Password and Confirm
        if let imgPassword = UIImage(named: "ic_Lock")
        {
            self.imgViewPassword.image = imgPassword.withRenderingMode(.alwaysTemplate)
            self.imgViewPassword.tintColor = AppColor.appMainGreyColor
            self.imgViewConfirmPassword.image = imgPassword.withRenderingMode(.alwaysTemplate)
            self.imgViewConfirmPassword.tintColor = AppColor.appMainGreyColor
        }
        
        self.txtPassword.attributedPlaceholder = NSAttributedString.init(string: "Password", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtPassword.tintColor = AppColor.appDarkPinkColor
        self.txtPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtConfirmPassword.attributedPlaceholder = NSAttributedString.init(string: "Confirm Password", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtConfirmPassword.tintColor = AppColor.appDarkPinkColor
        self.txtConfirmPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        //Mobile
        if let imgMoblile = UIImage(named: "ic_Mobile")
        {
            self.imgViewMobile.image = imgMoblile.withRenderingMode(.alwaysTemplate)
            self.imgViewMobile.tintColor = AppColor.appGreenColor
        }
        self.txtMobile.attributedPlaceholder = NSAttributedString.init(string: "Mobile Number", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtMobile.tintColor = AppColor.appDarkPinkColor
        self.txtMobile.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        guard let country = CountryManager.shared.currentCountry else {
            self.txtCountry.attributedPlaceholder = NSAttributedString.init(string: "Select your country", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
            self.imgViewCountry.isHidden = true
            return
        }
        self.selectedCounrtyName = country.countryName
        self.selectedCounrtyId = country.countryCode
        
        self.imgViewCountry.image = country.flag
        self.txtCountry.attributedPlaceholder = NSAttributedString.init(string: country.countryName, attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtCountry.font = UIFont(name: kAppRegularFont, size: 16.0)
    }
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        CommonUtility().addRoundCorners(view: self.btnRegister, radius: AppRoundedTheme.roundedCornerRadiusForContainer)
        
        CommonUtility().addShadowToView(view: self.shadowEmailContainerView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.emailContainerView, radius: 20)
        
        CommonUtility().addShadowToView(view: self.shadowFirstNameContainerView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.firstNameContainerView, radius: 20)
        
        CommonUtility().addShadowToView(view: self.shadowLastNameContainerView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.lastNameContainerView, radius: 20)
        
        CommonUtility().addShadowToView(view: self.shadowPasswordContainerView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.passwordContainerView, radius: 20)
        
        CommonUtility().addShadowToView(view: self.shadowConfirmPasswordView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.confirmPasswordContainerView, radius: 20)
        
        CommonUtility().addShadowToView(view: self.shadowMobileContainerView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.mobileContainerView, radius: 20)
        
        CommonUtility().addShadowToView(view: self.shadowCountryContainerView, ShadowColor: UIColor.lightGray, ShadowOpacity: 0.3, shadowOffset: CGSize(width: 0.5, height: 1.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.countryContainerView, radius: 20)
    }
    // MARK: - Button Actions
    @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        self.view.endEditing(true)
        if (self.checkValidations()) {
            self.callServiceForUserRegister()
        }
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if (textField == txtCountry)
        {
            self.view.endEditing(true)
            IQKeyboardManager.shared().resignFirstResponder()
            let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
                
                guard let self = self else { return }
                
                self.imgViewCountry.image = country.flag
                self.txtCountry.attributedPlaceholder = NSAttributedString.init(string: country.countryName, attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
                self.selectedCounrtyName = country.countryName
                self.selectedCounrtyId = country.countryCode
                
            }
            
            countryController.labelFont = UIFont(name: kAppRegularFont, size: 16)!
            countryController.flagStyle = CountryFlagStyle.circular
            countryController.isCountryDialHidden = true
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == txtEmail)
        {
            let maxLength = 128
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if(textField == txtFirstName)
        {
            let maxLength = 128
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if(textField == txtLastName)
        {
            let maxLength = 128
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if(textField == txtPassword)
        {
            let maxLength = 128
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if(textField == txtConfirmPassword)
        {
            let maxLength = 128
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if(textField == txtMobile)
        {
            let maxLength = 15
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return false
    }
    
    
    // MARK: - Validations
    
    func checkValidations() -> Bool {
        
        let result = false
        var validationMessage : String!
        
        let trimmedEmail = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if checkNullValue(txtField: self.txtEmail)
        {
            validationMessage = "Please enter email"
        }
        else if !CommonUtility().validateEmail(emailStr: trimmedEmail)
        {
            validationMessage = "Please enter valid email address"
        }
        else if self.checkNullValue(txtField: self.txtFirstName)
        {
            validationMessage = "Please enter first name"
        }
        else if self.checkNullValue(txtField: txtLastName)
        {
            validationMessage = "Please enter last name"
        }
        else if self.checkNullValue(txtField: txtPassword)
        {
            validationMessage = "Please enter password"
        }
        else if self.checkNullValue(txtField: txtConfirmPassword)
        {
            validationMessage = "Please enter confirm password"
        }
        else if (txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) != txtConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines))
        {
            validationMessage = "Password and Confirm password does not match"
        }
        else if self.checkNullValue(txtField: txtMobile)
        {
            validationMessage = "Please enter mobile number"
        }
        else if self.selectedCounrtyName == "" && self.selectedCounrtyName == "Select your country"
        {
            validationMessage = "Please select your country"
        }
        else{
            return true
        }
        
        self.showAlertWithMessageWithTitle(title: "Registration", message: validationMessage)
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
    
    // MARK: - Service Call
    
    func callServiceForUserRegister(){
        
        if CommonUtility().isConnectedToNetwork() {
            
            if let email = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines),let firstName = self.txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines),let lastName = self.txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines),let mobileNo = self.txtMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            {
                self.showHud("")
                    
                WebserviceManager().registerNewUser(emailId: email, password: password, firstName: firstName, lastName: lastName, mobileNo: mobileNo, countyId: self.selectedCounrtyId, countyName: self.selectedCounrtyName,isFromSocialLogIn: false) { (registerData,status, errorMessage) in
                    if (status == true)
                    {
                        if let userRegisterModel = registerData
                        {
                            UserDefaultsManager.saveUserLoggedInFlag(loggedIn: true)
                            self.openHome()
                        }
                    }
                    else{
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithTitle(title: "Registration", message: errorMsg)
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
    
    // MARK: Supporting Methods
    func openHome() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setHomeViewNavBar()
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
