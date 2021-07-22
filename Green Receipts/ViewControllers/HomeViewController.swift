//
//  HomeViewController.swift
//  Green Receipts
//
//  Created by Mansur on 10/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    typealias getAllHomeDataCallBack = (Bool) -> Void
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var tabBarContainerView: UIView!
    @IBOutlet weak var scannerContainerView: UIView!
    
    @IBOutlet weak var btnScanner: UIButton!
    @IBOutlet weak var imgViewScanner: UIImageView!
    @IBOutlet weak var libraryContainerView: UIView!
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var btnLibraryView: UIView!
    @IBOutlet weak var lblRecents: UILabel!
    @IBOutlet weak var lblNoOfReceipt: UILabel!
    @IBOutlet weak var imgViewLibraryProfile: UIImageView!
    @IBOutlet weak var btnCategoryView: UIView!
    @IBOutlet weak var imgViewLibrary: UIImageView!
    @IBOutlet weak var lblLibrary: UILabel!
    
    @IBOutlet weak var imgViewCategory: UIImageView!
    @IBOutlet weak var imgViewCategoryProfiile: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblCategoryHeader: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var stkViewLibrary: UIStackView!
    
    var isLibraryVisible: Bool = true
    
    @IBOutlet weak var stkViewCategory: UIStackView!
    
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imgViewCamera: UIImageView!
    
    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var imagePicker: UIImagePickerController!
    var arrUserLatestBills = [UserLatestBillModel]()
    var arrCameraUploads = [UserCameraUploadedBillModel]()
    var totalRecords: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.libraryTableView.register(UINib.init(nibName: "CameraRollTableViewCell", bundle: nil), forCellReuseIdentifier: "CameraRollTableViewCell")
        self.libraryTableView.register(UINib.init(nibName: "LibraryCell", bundle: nil), forCellReuseIdentifier: "LibraryCell")
       // self.libraryTableView.rowHeight = UITableView.automaticDimension
        self.libraryTableView.backgroundColor = .clear
        
        self.categoryCollectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        self.categoryCollectionView.backgroundColor = .clear
        
        // Do any additional setup after loading the view.
        //Library
        let showLibraryTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showLibrary(tapGestureRecognizer:)))
        self.stkViewLibrary.isUserInteractionEnabled = true
        self.stkViewLibrary.addGestureRecognizer(showLibraryTapGestureRecognizer)
        if let imgLibrary = UIImage(named: "ic_Library")
        {
            self.imgViewLibrary.image = imgLibrary.withRenderingMode(.alwaysTemplate)
            
        }
        self.lblLibrary.text = "Library"
        
        self.lblRecents.text = "Recents"
        self.lblRecents.font = UIFont(name: kAppBoldFont, size: 20)
        self.lblNoOfReceipt.font = UIFont(name: kAppRegularFont, size: 14)
        
        let showLibraryProfileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProfile(tapGestureRecognizer:)))
        self.imgViewLibraryProfile.isUserInteractionEnabled = true
        self.imgViewLibraryProfile.addGestureRecognizer(showLibraryProfileTapGestureRecognizer)
        
        if let imgPleople = UIImage(named: "ic_People")
        {
            self.imgViewLibraryProfile.image = imgPleople.withRenderingMode(.alwaysTemplate)
            self.imgViewLibraryProfile.tintColor = AppColor.appGreenColor
        }
        //Category
        let showCategoryTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCategory(tapGestureRecognizer:)))
        self.stkViewCategory.isUserInteractionEnabled = true
        self.stkViewCategory.addGestureRecognizer(showCategoryTapGestureRecognizer)
        if let imgCategory = UIImage(named: "ic_Category")
        {
            self.imgViewCategory.image = imgCategory.withRenderingMode(.alwaysTemplate)
            
        }
        self.lblCategory.text = "Category"
        self.lblCategory.textColor = UIColor.darkGray
        self.lblCategoryHeader.text = "Categories"
        self.lblCategoryHeader.font = UIFont.systemFont(ofSize: 24)
        
        let showCategoryProfileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProfile(tapGestureRecognizer:)))
        self.imgViewCategoryProfiile.isUserInteractionEnabled = true
        self.imgViewCategoryProfiile.addGestureRecognizer(showCategoryProfileTapGestureRecognizer)
        if let imgPleople = UIImage(named: "ic_People")
        {
            self.imgViewCategoryProfiile.image = imgPleople.withRenderingMode(.alwaysTemplate)
            self.imgViewCategoryProfiile.tintColor = AppColor.appGreenColor
        }
        
        //Scanner
        self.btnScanner.backgroundColor = AppColor.appGreenColor
        if let imgQRScan = UIImage(named: "ic_QrcodeScan")
        {
            self.imgViewScanner.image = imgQRScan.withRenderingMode(.alwaysTemplate)
            self.imgViewScanner.tintColor = UIColor.white
        }
        
        //Camera
        
        if let imgCamera = UIImage(named: "ic_Camera")
        {
            self.imgViewCamera.image = imgCamera
            // self.imgViewCamera.tintColor = UIColor.white
        }
        let showCameraOrGalleryTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showGallery(tapGestureRecognizer:)))
        self.cameraView.isUserInteractionEnabled = true
        self.cameraView.addGestureRecognizer(showCameraOrGalleryTapGestureRecognizer)
        
        self.categoryContainerView.backgroundColor = AppColor.appLightWhiteColor
        self.libraryContainerView.backgroundColor = AppColor.appLightWhiteColor
        self.scannerContainerView.backgroundColor = UIColor.white
        self.tabBarContainerView.backgroundColor = UIColor.white
        
        self.setUpTabBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.getDatafromServer()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CommonUtility().addRoundCorners(view: self.scannerContainerView, radius: 50)
        CommonUtility().addRoundCorners(view: self.btnScanner, radius: 42)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            CommonUtility().addShadowToView(view: self.cameraContainerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.1, shadowOffset: CGSize(width: 1.0, height: 1.0), ShadowRadius: 2)
        }
        CommonUtility().addRoundCorners(view: self.cameraContainerView, radius: 42)
        CommonUtility().addRoundCorners(view: self.cameraView, radius: 40)
        
    }
    
    func setUpTabBar() {
        
        if self.isLibraryVisible
        {
            self.imgViewLibrary.tintColor = AppColor.appGreenColor
            self.lblLibrary.textColor = AppColor.appGreenColor
            self.imgViewCategory.tintColor = UIColor.darkGray
            self.lblCategory.textColor = UIColor.darkGray
            self.libraryContainerView.isHidden = false
            self.categoryContainerView.isHidden = true
        }
        else
        {
            self.imgViewLibrary.tintColor = UIColor.darkGray
            self.lblLibrary.textColor = UIColor.darkGray
            self.imgViewCategory.tintColor = AppColor.appGreenColor
            self.lblCategory.textColor = AppColor.appGreenColor
            self.libraryContainerView.isHidden = true
            self.categoryContainerView.isHidden = false
        }
    }
    
    // MARK: - Button Actions
    @objc func showCategory(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.isLibraryVisible = false
        self.getDatafromServer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
        self.setUpTabBar()
        }
    }
    
    @objc func showLibrary(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.isLibraryVisible = true
        self.getDatafromServer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
        self.setUpTabBar()
        }
    }
    
    @objc func showProfile(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.goToProfile()
    }
    
    @objc func showGallery(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.openActionSheet()
    }
    
    @IBAction func ScannerClicked(_ sender: Any) {
        
        self.goToScanner()
    }
    //MARK: - Supporting Methods
    
    func getDatafromServer()
    {
        self.getUserLatestBill(){ (success) in
            self.getCameraUploads()
        }
    }
    
    func goToScanner() {
        
        let qrScannerVC = QRCodeScannerViewController.init(nibName: "QRCodeScannerViewController", bundle: nil)
        self.navigationController?.pushViewController(qrScannerVC, animated: true)
        
    }
    func goToProfile() {
        let userProfileVC = UserProfileViewController.init(nibName: "UserProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    // MARK: - Tableview Datasource and Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrUserLatestBills.count + 1
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as LibraryCell = cell else {
            return
        }
        cell.backgroundColor = .clear
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var finalCell: UITableViewCell
        
        if self.arrUserLatestBills.count > 0
        {
            
            if indexPath.row == arrUserLatestBills.count
            {
                let cell:CameraRollTableViewCell = self.libraryTableView.dequeueReusableCell(withIdentifier: "CameraRollTableViewCell", for: indexPath) as! CameraRollTableViewCell
                
                finalCell = cell
                
            }
            else
            {
                let cell:LibraryCell = self.libraryTableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as! LibraryCell
                
                let userLatestBillData = self.arrUserLatestBills[indexPath.row]
                
                if let billImageUrl = userLatestBillData.billImg
                {
                    let imageURL = kAppwebURl + billImageUrl
                    cell.imgReceiptView.sd_setImage(with:URL(string: imageURL), placeholderImage:UIImage(named:"ic_Receipt"))
                }
                if let billStore = userLatestBillData.billStore
                {
                    cell.lblCameraRoll.text = billStore
                }
                if let billLocation = userLatestBillData.billLocation, let billStore = userLatestBillData.billStore
                {
                    cell.lblLocation.text = billStore + "," + billLocation
                }
                if let billDate = userLatestBillData.billname
                {
                    cell.lblDate.text = billDate
                }
                
                finalCell = cell
            }
        }
        else
        {
            let cell:CameraRollTableViewCell = self.libraryTableView.dequeueReusableCell(withIdentifier: "CameraRollTableViewCell", for: indexPath) as! CameraRollTableViewCell
            
            finalCell = cell
        }
        finalCell.selectionStyle = .none
        return finalCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrUserLatestBills.count
        {
            let cameraRollVC = CameraRollViewController.init(nibName: "CameraRollViewController", bundle: nil)
            self.navigationController?.pushViewController(cameraRollVC, animated: true)
        }
        
        else
        {
            let receiptListVC = ReceiptListByShopViewController.init(nibName: "ReceiptListByShopViewController", bundle: nil)
            let userLatestBillData = self.arrUserLatestBills[indexPath.row]
            if let billStore = userLatestBillData.billStore
            {
                receiptListVC.strShopName = billStore
            }
            self.navigationController?.pushViewController(receiptListVC, animated: true)
        }
    }
    
    // MARK: - CollectionView Datasource and Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUserLatestBills.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.containerView.backgroundColor = .random
        
        if indexPath.row == arrUserLatestBills.count
        {
            cell.lblCategorytype.text = "Camera Roll"
            cell.lblTotalReceipt.isHidden = true
            if let imgCamera = UIImage(named: "ic_CaptureCamera")
            {
                cell.categoryImageView.image = imgCamera
            }
        }
        else
        {
            let userLatestBillData = self.arrUserLatestBills[indexPath.row]
            
            if let billStore = userLatestBillData.billStore
            {
                cell.lblCategorytype.text = billStore
            }
            if let noOfReceipt = userLatestBillData.totReceipt
            {
                cell.lblTotalReceipt.text = noOfReceipt + " " + "Receipts"
                cell.lblTotalReceipt.isHidden = false
            }
            if let imgCamera = UIImage(named: "ic_shop")
            {
                cell.categoryImageView.image = imgCamera
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case let cell as CategoryCollectionViewCell = cell else {
            return
        }
        cell.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.categoryCollectionView.frame.width/2 - 8
        let height = self.categoryCollectionView.frame.height/4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == arrUserLatestBills.count
        {
            let cameraRollVC = CameraRollViewController.init(nibName: "CameraRollViewController", bundle: nil)
            
            self.navigationController?.pushViewController(cameraRollVC, animated: true)
        }
        else
        {
            let receiptListVC = ReceiptListByShopViewController.init(nibName: "ReceiptListByShopViewController", bundle: nil)
            let userLatestBillData = self.arrUserLatestBills[indexPath.row]
            if let billStore = userLatestBillData.billStore
            {
                receiptListVC.strShopName = billStore
            }
            self.navigationController?.pushViewController(receiptListVC, animated: true)
        }
    }
    
    // MARK: - Service Call
    
    func getUserLatestBill(completion:@escaping getAllHomeDataCallBack)
    {
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            
            if  token != ""
            {
                self.showHud("")
                WebserviceManager().getUserLatestBill(token: token) { (arrayResponce,success, errorMessage,records) in
                    
                    self.hideHud()
                    
                    if success
                    {
                        if let arrayLatestBillList = arrayResponce
                        {
                            self.arrUserLatestBills = arrayLatestBillList
                        }
                        else
                        {
                            self.arrUserLatestBills = [UserLatestBillModel]()
                        }
                        if records != 0
                        {
                            self.totalRecords = records
                        }
                        
                        
                        DispatchQueue.main.async {
                            /*self.lblNoOfReceipt.text = String(self.totalRecords) + " Receipts"
                            self.libraryTableView.reloadData()
                            self.categoryCollectionView.reloadData()*/
                            completion(true)
                        }
                    }
                    else{
                        /*var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }*/
                        
                        DispatchQueue.main.async {
                            //self.showAlertWithMessageWithTitle(title: "", message: errorMsg)
                            completion(false)
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
    
    func uploadCameraImage(imgData:Data)
    {
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            let dateString = CommonUtility().getCurrentDateInString()
            if  token != ""
            {
                self.showHud("")
                WebserviceManager().uploadCameraImage(token: token,billTimeStamp: dateString,imgData: imgData) { (success, errorMessage) in
                    
                    self.hideHud()
                    
                    if success
                    {
                        var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "file uploaded Successfully!!!"
                        }
                        
                        DispatchQueue.main.async {
                            self.showAlertWithMessageWithTitle(title: "", message: errorMsg)
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
                            var totalRecordsToDisplay: Int = 0
                            if let records = self.totalRecords
                            {
                             totalRecordsToDisplay = records + self.arrCameraUploads.count
                            }
                            else
                            {
                                totalRecordsToDisplay = self.arrCameraUploads.count
                            }
                            self.lblNoOfReceipt.text = String(totalRecordsToDisplay) + " Receipts"
                            self.libraryTableView.reloadData()
                            self.categoryCollectionView.reloadData()
                           
                        }
                    }
                    else{
                       /* var errorMsg: String = errorMessage
                        if errorMessage == ""
                        {
                            errorMsg = "Something went worng!. Please try after sometime"
                        }
                        */
                        DispatchQueue.main.async {
                            //self.showAlertWithMessageWithTitle(title: "Camera Upload", message: errorMsg)
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
    
    //MARK: - Camera
    
    func openActionSheet() {
        
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraButton = UIAlertAction(title: "Camera", style: .default)
        { _ in
            self.openCameraUI(type: .camera)
        }
        actionSheet.addAction(cameraButton)
        
        let galleryButton = UIAlertAction(title: "Gallery", style: .default)
        { _ in
            self.openCameraUI(type: .photoLibrary)
        }
        actionSheet.addAction(galleryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        { _ in
           
        }
        actionSheet.addAction(cancelButton)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openCameraUI(type: UIImagePickerController.SourceType)
    {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(type) {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = type
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Camera Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.5)
        {
            self.uploadCameraImage(imgData: imageData)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
