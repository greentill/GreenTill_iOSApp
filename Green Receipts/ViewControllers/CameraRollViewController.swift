//
//  CameraRollViewController.swift
//  Green Receipts
//
//  Created by Mansur on 30/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit
import SDWebImage

class CameraRollViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblCameraRoll: UILabel!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var camearUploadCollectionView: UICollectionView!
    
    var arrCameraUploads = [UserCameraUploadedBillModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.camearUploadCollectionView.register(UINib.init(nibName: "CameraUploadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CameraUploadCollectionViewCell")
        self.camearUploadCollectionView.backgroundColor = .clear
        
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backClicked(tapGestureRecognizer:)))
        self.imgViewBack.isUserInteractionEnabled = true
        self.imgViewBack.addGestureRecognizer(backButtonTapGestureRecognizer)
        if let imgBack = UIImage(named: "ic_BackArrow")
        {
            self.imgViewBack.image = imgBack.withRenderingMode(.alwaysTemplate)
            self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        self.lblCameraRoll.text = "Camera Rolls"
        self.lblCameraRoll.textColor = UIColor.black
        self.lblCameraRoll.font = UIFont(name: kAppRegularFont, size: 20.0)
        self.separatorView.backgroundColor = AppColor.appMainGreyColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCameraUploads()
    }

    // MARK: - Button Actions

    @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CollectionView Datasource and Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.arrCameraUploads.count > 0)
        {
            collectionView.backgroundView = nil
        }
        else
        {
            let  noDataLable = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLable.text = "You have no Camera Uploads"
            noDataLable.textColor = .red
            noDataLable.font = UIFont(name: kAppRegularFont, size: 15.0)
            noDataLable.numberOfLines = 0
            noDataLable.textAlignment = .center
            collectionView.backgroundView = noDataLable

        }
        return arrCameraUploads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraUploadCollectionViewCell", for: indexPath) as! CameraUploadCollectionViewCell
        
        let cameraUploadData = self.arrCameraUploads[indexPath.row]
        
        if let uploadImageUrl = cameraUploadData.billImg
        {
            let imageURL = kAppwebURl + uploadImageUrl
            cell.uploadImageView.sd_setImage(with:URL(string: imageURL), placeholderImage:UIImage(named:"ic_CaptureCamera"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case let cell as CameraUploadCollectionViewCell = cell else {
            return
        }
        cell.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.camearUploadCollectionView.frame.width/3 - 8
        let height = self.camearUploadCollectionView.frame.height/5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showFullImage(index: indexPath.row)
    }
    // MARK: Supporting Methods
    
    func showFullImage(index: Int)
    {
        DispatchQueue.main.async {
            let fullImagePopupVC = FullImagePopUpViewController.init(nibName: "FullImagePopUpViewController", bundle: nil)
            let cameraUploadData = self.arrCameraUploads[index]
            if let uploadImageUrl = cameraUploadData.billImg
            {
                fullImagePopupVC.strImageUrl = uploadImageUrl
            }
            fullImagePopupVC.modalPresentationStyle = .overCurrentContext
            self.present(fullImagePopupVC, animated: true, completion: nil)
            
        }
    }
    // MARK: - Service Call
    
    func getCameraUploads()
    {
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            
            if  token != ""
            {
                self.showHud("")
                WebserviceManager().getCameraUplods(token: token) { (arrayResponce,success, errorMessage) in
                    
                    self.hideHud()
                    
                    if success
                    {
                        if let arrayCameraUploadList = arrayResponce
                        {
                            self.arrCameraUploads = arrayCameraUploadList
                        }
                        else
                        {
                            self.arrCameraUploads = [UserCameraUploadedBillModel]()
                        }
                        
                        DispatchQueue.main.async {
                            self.camearUploadCollectionView.reloadData()
                        }
                    }
                    else{
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithTitle(title: "Camera Upload", message: errorMsg)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
