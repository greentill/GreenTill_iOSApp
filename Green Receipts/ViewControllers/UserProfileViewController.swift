//
//  UserProfileViewController.swift
//  Green Receipts
//
//  Created by Mansur on 10/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FBSDKLoginKit
import GoogleSignIn

class UserProfileViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var profileHeaderView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserCountry: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var imgViewEdit: UIImageView!
    
    @IBOutlet weak var imgViewFirstName: UIImageView!
    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    //@IBOutlet weak var firstNameSeparatorView: UIView!
    @IBOutlet weak var imgViewLastName: UIImageView!
    @IBOutlet weak var txtLastName: SkyFloatingLabelTextField!
   // @IBOutlet weak var lastNameSeparatorView: UIView!
    @IBOutlet weak var imgViewEmail: UIImageView!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
   // @IBOutlet weak var emailSeparatorVIew: UIView!
    @IBOutlet weak var imgViewMobile: UIImageView!
     @IBOutlet weak var txtMobile: SkyFloatingLabelTextField!
   // @IBOutlet weak var mobileSeparatorView: UIView!
    @IBOutlet weak var changePasswordContainerView: UIView!
    @IBOutlet weak var changePasswordShadowContainerView: UIView!
    @IBOutlet weak var changePasswordImgView: UIImageView!
    
    var isEditProfile: Bool = false
    
    var profileDataModel: UserProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backClicked(tapGestureRecognizer:)))
        self.imgViewBack.isUserInteractionEnabled = true
        self.imgViewBack.addGestureRecognizer(backButtonTapGestureRecognizer)
        if let imgBack = UIImage(named: "ic_BackArrow")
        {
            self.imgViewBack.image = imgBack.withRenderingMode(.alwaysTemplate)
            self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        
        
//        CommonUtility().addpaddingToLeftofTextField(textField: txtEmail)
//        CommonUtility().addpaddingToLeftofTextField(textField: txtFirstName)
//        CommonUtility().addpaddingToLeftofTextField(textField: txtLastName)
//        CommonUtility().addpaddingToLeftofTextField(textField: txtMobile)
        
        self.lblProfile.text = "Profile"
        lblProfile.textColor = AppColor.appMainGreyColor
        lblProfile.font = UIFont(name: kAppBoldFont, size: 20.0)
        
        
        lblUserName.textColor = AppColor.appMainGreyColor
        lblUserName.font = UIFont(name: kAppBoldFont, size: 24.0)
        
        lblUserCountry.textColor = AppColor.appMainGreyColor
        lblUserCountry.font = UIFont(name: kAppRegularFont, size: 18.0)
        
        self.btnLogout.backgroundColor = AppColor.appGreenColor
        self.btnLogout.setTitle("Logout", for: .normal)
        self.btnLogout.setTitleColor(UIColor.white, for: .normal)
        self.btnLogout.titleLabel?.font = UIFont(name: kAppBoldFont, size: 16.0)
        
        self.btnUpdate.backgroundColor = AppColor.appGreenColor
        self.btnUpdate.setTitle("Update", for: .normal)
        self.btnUpdate.setTitleColor(UIColor.white, for: .normal)
        self.btnUpdate.titleLabel?.font = UIFont(name: kAppBoldFont, size: 16.0)
        //Edit
        
        let editButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editClicked(tapGestureRecognizer:)))
        self.imgViewEdit.isUserInteractionEnabled = true
        self.imgViewEdit.addGestureRecognizer(editButtonTapGestureRecognizer)
        if let imgEdit = UIImage(named: "ic_Edit")
        {
            self.imgViewEdit.image = imgEdit
        }
        
        //Email
        if let imgEmail = UIImage(named: "ic_EmailAddress")
        {
            self.imgViewEmail.image = imgEmail.withRenderingMode(.alwaysTemplate)
            self.imgViewEmail.tintColor = AppColor.appRedColor
        }
        //self.txtEmail.placeholder = "Enter your email"
        //self.txtEmail.title = "Enter your email"
        self.txtEmail.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtEmail.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtEmail.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtEmail.tintColor = AppColor.appDarkPinkColor
        self.txtEmail.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtEmail.selectedLineColor = AppColor.appDarkPinkColor
        
        
        //First Name
        if let imgPleople = UIImage(named: "ic_People")
        {
            self.imgViewFirstName.image = imgPleople.withRenderingMode(.alwaysTemplate)
            self.imgViewFirstName.tintColor = AppColor.appMainGreyColor
        }
        //self.txtFirstName.placeholder = "Enter your first name"
        //self.txtFirstName.title = "Enter your first name"
        self.txtFirstName.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtFirstName.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtFirstName.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtFirstName.tintColor = AppColor.appDarkPinkColor
        self.txtFirstName.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtFirstName.selectedLineColor = AppColor.appDarkPinkColor
       // self.lastNameSeparatorView.backgroundColor = UIColor.black
        
        //Last Name
        if let imgPleople = UIImage(named: "ic_People")
        {
            self.imgViewLastName.image = imgPleople.withRenderingMode(.alwaysTemplate)
            self.imgViewLastName.tintColor = AppColor.appMainGreyColor
        }
        //self.txtLastName.placeholder = "Enter your last name"
        //self.txtLastName.title = "Enter your last name"
        self.txtLastName.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtLastName.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtLastName.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtLastName.tintColor = AppColor.appDarkPinkColor
        self.txtLastName.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtLastName.selectedLineColor = AppColor.appDarkPinkColor
       
        
        //Mobile
        if let imgMoblile = UIImage(named: "ic_Mobile")
        {
            self.imgViewMobile.image = imgMoblile.withRenderingMode(.alwaysTemplate)
            self.imgViewMobile.tintColor = AppColor.appGreenColor
        }
        //self.txtMobile.placeholder = "Enter your mobile number"
        //self.txtMobile.title = "Enter your mobile number"
        self.txtMobile.placeholderFont = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtMobile.titleFont = UIFont(name: kAppRegularFont, size: 16.0)!
        self.txtMobile.font = UIFont(name: kAppRegularFont, size: 16.0)
        self.txtMobile.tintColor = AppColor.appDarkPinkColor
        self.txtMobile.selectedTitleColor = AppColor.appDarkPinkColor
        self.txtMobile.selectedLineColor = AppColor.appDarkPinkColor
        
        //Password
        
        let ChangePasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePassowrdClicked(tapGestureRecognizer:)))
        self.changePasswordImgView.isUserInteractionEnabled = true
        self.changePasswordImgView.addGestureRecognizer(ChangePasswordTapGestureRecognizer)
        if let imgPassword = UIImage(named: "ic_Password")
        {
            self.changePasswordImgView.image = imgPassword
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setGradientBackground()
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.getUserProfileFromServer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CommonUtility().addRoundCorners(view: self.btnLogout, radius: 20)
        CommonUtility().addRoundCorners(view: self.btnUpdate, radius: 25)
        CommonUtility().addShadowToView(view: self.changePasswordShadowContainerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.2, shadowOffset: CGSize(width: 1.0, height: 1.0), ShadowRadius: 3)
        CommonUtility().addRoundCorners(view: self.changePasswordContainerView, radius: 29)
        CommonUtility().addRoundCorners(view: self.changePasswordShadowContainerView, radius: 31)
    }
    
    func setGradientBackground() {
        let colorLeft = AppColor.appLimeGreenColor.cgColor
        let colorRight = AppColor.appBlueColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.profileHeaderView.bounds
                
        self.profileHeaderView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func loadProfileData()
    {
        if let profileModel = profileDataModel
        {
            if let userName = profileModel.firstname ,let userLastName = profileModel.lastname
            {
                self.lblUserName.text = userName + " " + userLastName
                self.txtFirstName.text = userName
                self.txtLastName.text = userLastName
            }
            if let userCountry = profileModel.countyname
            {
                self.lblUserCountry.text = userCountry
            }
            if let userEmail = profileModel.email
            {
                self.txtEmail.text = userEmail
            }
            if let userMobile = profileModel.mobileno
            {
                self.txtMobile.text = userMobile
            }
        }
        else
        {
            self.lblUserName.text = ""
            self.lblUserCountry.text = ""
            self.txtFirstName.text = ""
            self.txtLastName.text = ""
            self.txtEmail.text = ""
            self.txtMobile.text = ""
        }
    }
    
     // MARK: - Button Actions

    @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(UIAlertAction) in
            let loginManager = LoginManager()
            loginManager.logOut()
            GIDSignIn.sharedInstance().signOut()
             self.removeDataOnLogout()
        }))
        alert.addAction(UIAlertAction(title:"No", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    @objc func editClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.isEditProfile = true
    }
    @objc func changePassowrdClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let changePasswordVC = ChangePasswordViewController.init(nibName: "ChangePasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    func removeDataOnLogout() {
        
        DispatchQueue.main.async {
            UserDefaultsManager.saveUserLoggedInFlag(loggedIn: false)
            UserDefaultsManager.removeUserInformationDictionary()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setLoginViewNavBar()
        }
    }
    
    // MARK: - Service Call
    
    func getUserProfileFromServer(){
        
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            
            if  token != ""
            {
                self.showHud("")
                WebserviceManager().getUserProfile(token: token) { (profileData,status, errorMessage) in
                    
                    self.hideHud()
                    
                    if (status == true)
                    {
                        if let profileMod = profileData
                        {
                            self.profileDataModel = profileMod
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:{
                            self.loadProfileData()
                        } )
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
                    
                    
                }
                
            } else {
                
            }
        } else
        {
            let errorMSg = "Internet connection seems to be offline. Please check your internet connection"
            self.showAlertWithMessageWithTitle(title: "Internet Connection", message: errorMSg)
        }
    }
    
    // MARK: - textfield delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if self.isEditProfile
        {
            if textField == txtEmail
            {
                self.txtEmail.placeholder = "Enter your email"
                self.txtFirstName.placeholder = ""
                self.txtLastName.placeholder = ""
                self.txtMobile.placeholder = ""
            }
            else if textField == txtFirstName
            {
                self.txtFirstName.placeholder = "Enter your first name"
                self.txtEmail.placeholder = ""
                self.txtLastName.placeholder = ""
                self.txtMobile.placeholder = ""
            }
            else if textField == txtLastName
            {
                self.txtLastName.placeholder = "Enter your last name"
                self.txtEmail.placeholder = ""
                self.txtFirstName.placeholder = ""
                self.txtMobile.placeholder = ""
            }
            else if textField == txtMobile
            {
                self.txtMobile.placeholder = "Enter your mobile number"
                self.txtEmail.placeholder = ""
                self.txtFirstName.placeholder = ""
                self.txtLastName.placeholder = ""
            }
            return true
        }
        else
        {
            return false
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
