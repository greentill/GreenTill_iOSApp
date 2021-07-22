//
//  QRCodeScannerViewController.swift
//  Green Receipts
//
//  Created by Mansur on 20/03/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit
import MercariQRScanner

class QRCodeScannerViewController: BaseViewController,QRScannerViewDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblScanStatusTitle: UILabel!
    @IBOutlet weak var scannerView: QRScannerView!
    @IBOutlet weak var viewStatusUp: UIView!
    @IBOutlet weak var viewStatusDown: UIView!
    
    var qrCodeDataModel: QRInfoDataModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backClicked(tapGestureRecognizer:)))
        self.imgViewBack.isUserInteractionEnabled = true
        self.imgViewBack.addGestureRecognizer(backButtonTapGestureRecognizer)
        if let imgBack = UIImage(named: "ic_BackArrow")
        {
            self.imgViewBack.image = imgBack.withRenderingMode(.alwaysTemplate)
            self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        
        self.headerView.backgroundColor = AppColor.appLightWhiteColor
        self.viewStatusUp.backgroundColor = AppColor.appLightWhiteColor
        self.viewStatusDown.backgroundColor = AppColor.appLightWhiteColor
        
        self.lblScanStatusTitle.font = UIFont(name: kAppBoldFont, size: 20.0)
        self.lblScanStatusTitle.text = "Scan the QR code to get your receipt."
        
        self.scannerView.configure(delegate: self)
        self.scannerView.focusImagePadding = 8.0
        self.scannerView.animationDuration = 0.5
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.scannerView.startRunning()
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scannerView.stopRunning()
    }

    // MARK: - Button Actions

   @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
   {
       self.navigationController?.popViewController(animated: true)
   }
    
    // MARK: - QRScanner View Delegate
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError)
    {
        DispatchQueue.main.async {
            self.showAlertWithMessageWithTitle(title: "", message: "Something went worng!. Please try after sometime")
        }
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String)
    {
        if code != ""
        {
            self.getQRCodeData(qrString: code)
        }
    }
    
    // MARK: - Service Call
    
    func getQRCodeData(qrString:String)
    {
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            
            if  token != "" && qrString != ""
            {
                self.showHud("")
                WebserviceManager().getQRData(token: token, qrString: qrString) { (qrData,success, errorMessage) in
                    
                    self.hideHud()
                    
                    if success
                    {
                        if let unwrappedQRData = qrData
                        {
                            self.qrCodeDataModel = unwrappedQRData
                        }
                        
                        DispatchQueue.main.async {
                            self.goToSaveQRView(qrString: qrString)
                        }
                    }
                    else{
                        self.scannerView.stopRunning()
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        
                        DispatchQueue.main.async {
                            
                            self.lblScanStatusTitle.text = errorMsg
                            self.showAlertWithMessageWithCompletion(title: "", message: errorMsg, completion: {
                                self.scannerView.startRunning()
                                
                            })
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
    
    func goToSaveQRView(qrString:String) {
        
        let fullImageVC = SaveQRImageViewController.init(nibName: "SaveQRImageViewController", bundle: nil)
        fullImageVC.qrDetailData = self.qrCodeDataModel
        fullImageVC.qrCodeString = qrString
        self.navigationController?.pushViewController(fullImageVC, animated: true)
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
