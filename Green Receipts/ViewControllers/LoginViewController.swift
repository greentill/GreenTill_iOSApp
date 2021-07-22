//
//  LoginViewController.swift
//  Green Receipts
//
//  Created by Mansur on 10/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: BaseViewController,LoginButtonDelegate {
    

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var lblGreenTill: UILabel!
    @IBOutlet weak var lblReceipt: UILabel!
   
    @IBOutlet weak var ShadowEmailContainerView: UIView!
    @IBOutlet weak var imgViewShowPassword: UIImageView!
    @IBOutlet weak var viewEmailContainer: UIView!
    
    @IBOutlet weak var shadowPasswordContainerView: UIView!
    @IBOutlet weak var viewPasswordContainer: UIView!
    @IBOutlet weak var viewShowPasswordContainer: UIView!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnRegisterNow: UIButton!
    
    @IBOutlet weak var lblSignInWith: UILabel!
    
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var imgViewEmail: UIImageView!
    @IBOutlet weak var txtPassword: CustomTextField!
    @IBOutlet weak var imgViewPassword: UIImageView!
    @IBOutlet weak var lblShowPassword: UILabel!    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var btnFbView: UIView!
    
    var checkBoxSelected: Bool = false
    var userGoogleData: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        lblGreenTill.text = "Green Till"
        lblGreenTill.textColor = AppColor.appGreenColor
        lblGreenTill.font = UIFont(name: kAppBoldFont, size: 22.0)
        
        lblReceipt.text = "Receipts"
        lblReceipt.textColor = AppColor.appGreenColor
        lblReceipt.font = UIFont(name: kAppBoldFont, size: 22.0)
        
        lblShowPassword.text = "Show Password"
        lblShowPassword.textColor = UIColor.black
        lblShowPassword.font = UIFont(name: kAppRegularFont, size: 18.0)
        
        self.btnSignIn.titleLabel?.text = "Sign in"
        self.btnSignIn.backgroundColor = AppColor.appGreenColor
        self.btnSignIn.setTitleColor(UIColor.white, for: .normal)
        self.btnSignIn.titleLabel?.font = UIFont(name: kAppBoldFont, size: 15)
        
        self.btnForgotPassword.titleLabel?.text = "Forgot Password ?"
        self.btnForgotPassword.setTitleColor(AppColor.appMainGreyColor, for: .normal)
        self.btnForgotPassword.titleLabel?.font = UIFont(name: kAppRegularFont, size: 15)
        
        self.btnRegisterNow.titleLabel?.text = "New User? Register now"
        self.btnRegisterNow.setTitleColor(AppColor.appGreenColor, for: .normal)
        self.btnRegisterNow.titleLabel?.font = UIFont(name: kAppBoldFont, size: 17)
        
        lblSignInWith.text = "or Sign in with"
        lblSignInWith.textColor = AppColor.appMainGreyColor
        lblSignInWith.font = UIFont(name: kAppRegularFont, size: 17.0)
        
        CommonUtility().addpaddingToLeftofTextField(textField: txtEmail)
        CommonUtility().addpaddingToLeftofTextField(textField: txtPassword)
        
        
        self.txtEmail.attributedPlaceholder = NSAttributedString.init(string: "Email", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtEmail.tintColor = AppColor.appDarkPinkColor
        self.txtEmail.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtPassword.attributedPlaceholder = NSAttributedString.init(string: "Password", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        self.txtPassword.tintColor = AppColor.appDarkPinkColor
        self.txtPassword.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        if let imgLogo = UIImage(named: "logoo")
        {
            self.imgViewLogo.image = imgLogo
        }
        if let imgEmail = UIImage(named: "ic_Email")
        {
            self.imgViewEmail.image = imgEmail.withRenderingMode(.alwaysTemplate)
            self.imgViewEmail.tintColor = AppColor.appMainGreyColor
        }
        if let imgPassword = UIImage(named: "ic_Lock")
        {
            self.imgViewPassword.image = imgPassword.withRenderingMode(.alwaysTemplate)
            self.imgViewPassword.tintColor = AppColor.appMainGreyColor
        }
        
        let showPasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPasswordType(tapGestureRecognizer:)))
        self.imgViewShowPassword.isUserInteractionEnabled = true
        self.imgViewShowPassword.addGestureRecognizer(showPasswordTapGestureRecognizer)
        let showPasswordLableTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPasswordType(tapGestureRecognizer:)))
        self.lblShowPassword.isUserInteractionEnabled = true
        self.lblShowPassword.addGestureRecognizer(showPasswordLableTapGestureRecognizer)
        
        if checkBoxSelected
        {
           if let imgCheck = UIImage(named: "ic_check")
            {
                self.imgViewShowPassword.image = imgCheck.withRenderingMode(.alwaysTemplate)
                self.imgViewShowPassword.tintColor = AppColor.appGreenColor
            }
            self.txtPassword.isSecureTextEntry = false
        }
        else {
            if let imgCheck = UIImage(named: "ic_EmptyCheck")
            {
                self.imgViewShowPassword.image = imgCheck.withRenderingMode(.alwaysTemplate)
                self.imgViewShowPassword.tintColor = AppColor.appGreenColor
            }
            self.txtPassword.isSecureTextEntry = true
        }
        
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        //signInButton.style = GIDSignInButtonStyle.iconOnly
        
        
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 2, y: 2, width: self.btnFbView.frame.width - 4, height: self.btnFbView.frame.height - 4)
        loginButton.permissions = ["public_profile", "email"]
        loginButton.delegate = self
        self.btnFbView.addSubview(loginButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(gooleLoginSucceed), name: NSNotification.Name(rawValue: "GoogleSignInSuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gooleLoginFailed), name: NSNotification.Name(rawValue: "GoogleSignInFail"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        CommonUtility().addShadowToView(view: self.ShadowEmailContainerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.7, shadowOffset: CGSize(width: 1.0, height: 3.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.viewEmailContainer, radius: 18)
        
        CommonUtility().addShadowToView(view: self.shadowPasswordContainerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.7, shadowOffset: CGSize(width: 1.0, height: 3.0), ShadowRadius: 10)
        CommonUtility().addRoundCorners(view: self.viewPasswordContainer, radius: 18)
        CommonUtility().addRoundCorners(view: self.btnSignIn, radius: AppRoundedTheme.roundedCornerRadiusForContainer)

    }
    // MARK: - Button Actions
    
    @IBAction func newRegistrationClicked(_ sender: Any) {
        let registrationVC = RegistrationViewController.init(nibName: "RegistrationViewController", bundle: nil)
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        self.gotoForgotPassword()
    }
    func gotoForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController.init(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc func showPasswordType(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if !checkBoxSelected
        {
            self.checkBoxSelected = true
            if let imgCheck = UIImage(named: "ic_check")
            {
                self.imgViewShowPassword.image = imgCheck.withRenderingMode(.alwaysTemplate)
                self.imgViewShowPassword.tintColor = AppColor.appGreenColor
            }
            self.txtPassword.isSecureTextEntry = false
        }
        else{
            self.checkBoxSelected = false
            if let imgCheck = UIImage(named: "ic_EmptyCheck")
            {
                self.imgViewShowPassword.image = imgCheck.withRenderingMode(.alwaysTemplate)
                self.imgViewShowPassword.tintColor = AppColor.appGreenColor
            }
            self.txtPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnSigninClicked(_ sender: Any) {
        self.view.endEditing(true)
        if (self.checkValidations()) {
            self.callServiceForUserLogin()
        }
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
        else if self.checkNullValue(txtField: txtPassword)
        {
            validationMessage = "Please enter password"
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
    
    func callServiceForUserLogin(){
        
        if CommonUtility().isConnectedToNetwork() {
            
            if let userName = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            {
                self.showHud("")
                WebserviceManager().loginAuthenticateUser(userName: userName, password: password) { (loginData,status, errorMessage) in
                    
                    if (status == true)
                    {
                        if let userLoginModel = loginData
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
                            self.showAlertWithMessageWithTitle(title: "Login", message: errorMsg)
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
    
    func callServicegetGoogleData(token:String){
        
        if CommonUtility().isConnectedToNetwork() {
            
            if token != ""
            {
                self.showHud("")
                WebserviceManager().getGoogelData(accessToken: token) { (loginData,status, errorMessage) in
                    
                    if (status == true)
                    {
                        if let userGogData = loginData
                        {
                            self.userGoogleData = userGogData
                            if let googleData = self.userGoogleData
                            {
                                if let firstName = googleData["given_name"] as? String, let lastName = googleData["family_name"]as? String,let email = googleData["email"]as? String
                                {
                                    self.callServiceForUserRegister(firstName: firstName, lastName: lastName, email: email)
                                }
                                else
                                {
                                    DispatchQueue.main.async {
                                        let errorMsg = "Something went worng!. Please try after sometime"
                                        self.showAlertWithMessageWithTitle(title: "Login", message: errorMsg)
                                    }
                                }
                            }
                            else
                            {
                                DispatchQueue.main.async {
                                    let errorMsg = "Something went worng!. Please try after sometime"
                                    self.showAlertWithMessageWithTitle(title: "Login", message: errorMsg)
                                }
                            }
                        }
                    }
                    else{
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithTitle(title: "Login", message: errorMsg)
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
    
    func callServiceForUserRegister(firstName:String,lastName:String,email:String){
        
        if CommonUtility().isConnectedToNetwork() {
            self.showHud("")
            let password = email + "12"
            WebserviceManager().registerNewUser(emailId: email, password: password, firstName: firstName, lastName: lastName, mobileNo: "", countyId: "", countyName: "",isFromSocialLogIn: true) { (registerData,status, errorMessage) in
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
                        self.showAlertWithMessageWithTitle(title: "LogIn", message: errorMsg)
                    }
                }
                
                self.hideHud()
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
    @objc func gooleLoginSucceed(notification:NSNotification)
    {
        if let info = notification.userInfo as NSDictionary?
        {
            if let strToken = info["googleAccessToken"] as? String
            {
                self.callServicegetGoogleData(token: strToken
                )
            }
        }
    }
    
    @objc func gooleLoginFailed(notification:NSNotification)
    {
        
    }
    
    // MARK: - Facebook LogIn button Delegate
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        self.showFBUserData()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func showFBUserData()
        {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id, name, gender, first_name, last_name, locale, email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in

                if ((error) != nil)
                {
                    // Process error
                    //print("Error: \(String(describing: error))")
                }
                else
                {
                    let bUserFacebookDict = result as! NSDictionary
                    if let firstName = bUserFacebookDict.object(forKey: "first_name") as? String, let lastName = bUserFacebookDict.object(forKey: "last_name") as? String,let email =  bUserFacebookDict.object(forKey: "email") as? String
                    {
                        self.callServiceForUserRegister(firstName: firstName, lastName: lastName, email: email)
                    }
                    else
                    {
                        let errorMsg = "Something went worng!. Please try after sometime"
                        self.showAlertWithMessageWithTitle(title: "LogIn", message: errorMsg)
                    }
                    
                }
            })
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
