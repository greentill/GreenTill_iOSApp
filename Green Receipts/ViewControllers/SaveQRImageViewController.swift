//
//  SaveQRImageViewController.swift
//  Green Receipts
//
//  Created by Mansur on 17/04/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit

class SaveQRImageViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var imgViewSave: UIImageView!
    
    var qrDetailData: QRInfoDataModel?
    var qrCodeString: String! = ""
    
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
        
        let saveButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveClicked(tapGestureRecognizer:)))
        self.imgViewSave.isUserInteractionEnabled = true
        self.imgViewSave.addGestureRecognizer(saveButtonTapGestureRecognizer)
        if let imgSave = UIImage(named: "ic-Tick")
        {
            self.imgViewSave.image = imgSave.withRenderingMode(.alwaysTemplate)
            //self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        
        self.lblHeaderTitle.textColor = UIColor.black
        self.lblHeaderTitle.font = UIFont(name: kAppBoldFont, size: 20.0)
        self.separatorView.backgroundColor = AppColor.appMainGreyColor
        
        self.containerView.backgroundColor = AppColor.appGreenColor
        self.headerView.backgroundColor = AppColor.appGreenColor
        
        if let qrDetailDataModel = qrDetailData
        {
            if let strImageURL = qrDetailDataModel.billImg
            {
                let imageURL = kAppwebURl + strImageURL
                self.fullImageView.sd_setImage(with:URL(string: imageURL), placeholderImage:UIImage(named:"ic_CaptureCamera"))
            }
            if let strReceiptDate = qrDetailDataModel.billname
            {
                self.lblHeaderTitle.text = strReceiptDate
            }
        }

    }
    
    override func viewDidLayoutSubviews() {
        CommonUtility().addShadowToViewBounds(view: self.headerView, shadowColor: AppColor.appMainGreyColor, ShadowOpacity: 1.0, shadowOffset: CGSize(width: 0.0, height: 5), ShadowRadius: 10)
    }

    // MARK: - Button Actions

    @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if self.qrCodeString != ""
        {
            self.saveQRCodeData(qrString: self.qrCodeString)
        }
    }

    
    // MARK: - Service Call
    
    func saveQRCodeData(qrString:String)
    {
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            
            if  token != "" && qrString != ""
            {
                self.showHud("")
                WebserviceManager().saveQRData(token: token, qrString: qrString) { (qrData,success, errorMessage) in
                    
                    self.hideHud()
                    
                    if success
                    {
                        
                        DispatchQueue.main.async {
                            self.goToHome()
                        }
                    }
                    else{
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithTitle(title: "", message: errorMsg)
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
    
    // MARK: - Supporting Methods
    
    func goToHome() {
        
        if let appDelegte = UIApplication.shared.delegate as? AppDelegate
        {
            appDelegte.setHomeViewNavBar()
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
