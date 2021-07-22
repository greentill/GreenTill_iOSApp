//
//  ForgotPasswordViewController.swift
//  Green Receipts
//
//  Created by Mansur on 17/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var lblEnterEmail: UILabel!

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var imgViewEmail: UIImageView!
    @IBOutlet weak var btnSend: UIButton!
    
    var otpString: String = ""
    var userData: UserLoginModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let backIcon = UIImage.init(named: "ic_BackArrow")
        let backButton = UIBarButtonItem(image: backIcon, style: .done, target: self, action: #selector(backClicked))
        backButton.tintColor = AppColor.appMainGreyColor
        self.navigationItem.leftBarButtonItem = backButton
        
        let lblTitle = UILabel()
        lblTitle.text = "Forgot password"
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont(name: kAppRegularFont, size: 20.0)
        self.navigationItem.titleView = lblTitle
        
        self.lblEnterEmail.text = "Enter your email"
        lblEnterEmail.textColor = AppColor.appLightPinkColor
        lblEnterEmail.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        self.separatorView.backgroundColor = AppColor.appDarkPinkColor
        
        //Email
        if let imgEmail = UIImage(named: "ic_EmailAddress")
        {
            self.imgViewEmail.image = imgEmail.withRenderingMode(.alwaysTemplate)
            self.imgViewEmail.tintColor = AppColor.appRedColor
        }
        self.txtEmail.attributedPlaceholder = NSAttributedString.init(string: "", attributes: [NSAttributedString.Key.font: UIFont(name: kAppRegularFont, size: 16)!, NSAttributedString.Key.foregroundColor:AppColor.appMainGreyColor])
        
        self.txtEmail.tintColor = AppColor.appDarkPinkColor
        self.txtEmail.font = UIFont(name: kAppRegularFont, size: 16.0)
        
        
        self.btnSend.backgroundColor = AppColor.appGreenColor
        self.btnSend.setTitleColor(UIColor.white, for: .normal)
        self.btnSend.titleLabel?.font = UIFont(name: kAppBoldFont, size: 16)
        self.btnSend.titleLabel?.text = "Send"
        
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
    
    @IBAction func sendClicked(_ sender: Any) {
        self.view.endEditing(true)
        if (self.checkValidations()) {
            self.callServiceForForgotPasswordOTP()
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
    
    func callServiceForForgotPasswordOTP(){
        
        if CommonUtility().isConnectedToNetwork() {
            
            if let email = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            {
                otpString = self.generateOTP()
                self.showHud("")
                    
                WebserviceManager().requestForgotPaswordOTP(email: email,otpString: otpString) { (LogInData,status, errorMessage) in
                    if (status == true)
                    {
                        DispatchQueue.main.async {
                            if let unwrapedLogInData = LogInData
                            {
                                self.userData = unwrapedLogInData
                            }
                            self.doAlertControllerDemo()
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
    
    // MARK: - Supporting Methods
    
    func generateOTP() -> String {
        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while Set<Character>(result).count < 4
        return result
    }
    
    func goToResetPassword() {
        let resetPasswordVC = ResetPasswordViewController.init(nibName: "ResetPasswordViewController", bundle: nil)
        resetPasswordVC.userData = self.userData
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    func doAlertControllerDemo() {
        var inputTextField: UITextField?;
        let passwordPrompt = UIAlertController(title: "OTP", message: "Verify Email Address", preferredStyle: UIAlertController.Style.alert)
        
        passwordPrompt.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            // Now do whatever you want with inputTextField (remember to unwrap the optional)
           if let UnwappedEntryStr : String = (inputTextField?.text)
           {
            self.verifyOTP(inputOTP: UnwappedEntryStr)
           }

        }))
        passwordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            print("done");
            
        }))
        passwordPrompt.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter OTP"
            //textField. = false       /* true here for pswd entry */
            inputTextField = textField
        })
        self.present(passwordPrompt, animated: true, completion: nil)
        return
    }
    
    func verifyOTP(inputOTP: String){
        
        if inputOTP != "" && inputOTP.count == 4
        {
            if inputOTP == self.otpString
            {
                self.goToResetPassword()
            }
            else
            {
                DispatchQueue.main.async {
                    self.showAlertWithMessageWithCompletion(title: "OTP", message: "OTP Does not matched.", completion: {
                        self.doAlertControllerDemo()
                    })
                }
            }
        }else
        {
            DispatchQueue.main.async {
                self.showAlertWithMessageWithCompletion(title: "OTP", message: "Please enter valid OTP", completion: {
                    self.doAlertControllerDemo()
                })
            }
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
