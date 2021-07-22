//
//  ReceiptListByShopViewController.swift
//  Green Receipts
//
//  Created by Mansur on 11/04/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit

class ReceiptListByShopViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var receiptTableView: UITableView!
    
    var strShopName: String!
    var arrUserLBillsByShop = [UserLatestBillModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.receiptTableView.register(UINib.init(nibName: "LibraryCell", bundle: nil), forCellReuseIdentifier: "LibraryCell")
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backClicked(tapGestureRecognizer:)))
        self.imgViewBack.isUserInteractionEnabled = true
        self.imgViewBack.addGestureRecognizer(backButtonTapGestureRecognizer)
        if let imgBack = UIImage(named: "ic_BackArrow")
        {
            self.imgViewBack.image = imgBack.withRenderingMode(.alwaysTemplate)
            self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        self.lblShopName.textColor = UIColor.black
        self.lblShopName.font = UIFont(name: kAppRegularFont, size: 20.0)
        self.separatorView.backgroundColor = AppColor.appMainGreyColor
        if strShopName != "" {
            self.lblShopName.text = strShopName
            self.getUserLatestBillbyStore(storeName: strShopName)
        }
    }
    
    // MARK: - Button Actions

   @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
   {
       self.navigationController?.popViewController(animated: true)
   }
    
    // MARK: - Tableview Datasource and Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrUserLBillsByShop.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as LibraryCell = cell else {
            return
        }
        cell.backgroundColor = .clear
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell:LibraryCell = self.receiptTableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as! LibraryCell
        
        let userLatestBillData = self.arrUserLBillsByShop[indexPath.row]
        
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
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showFullImage(index: indexPath.row)
    }
    
    // MARK: Supporting Methods
    
    func showFullImage(index: Int)
    {
        DispatchQueue.main.async {
            let fullImageVC = FullImageViewController.init(nibName: "FullImageViewController", bundle: nil)
            let billBuShopData = self.arrUserLBillsByShop[index]
            if let uploadImageUrl = billBuShopData.billImg
            {
                fullImageVC.strImageUrl = uploadImageUrl
            }
            if let billName = billBuShopData.billname
            {
                fullImageVC.strReceiptDate = billName
            }
            fullImageVC.modalPresentationStyle = .overCurrentContext
            self.present(fullImageVC, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Service Call
    
    func getUserLatestBillbyStore(storeName:String)
    {
        if CommonUtility().isConnectedToNetwork() {
            
            let token = CommonUtility.getTokenOfLoggedInUser()
            
            if  token != "" && storeName != ""
            {
                self.showHud("")
                WebserviceManager().getUserBillByShop(token: token,store: storeName) { (arrayResponce,success, errorMessage,records) in
                    
                    self.hideHud()
                    
                    if success
                    {
                        if let arrayBillListByShop = arrayResponce
                        {
                            self.arrUserLBillsByShop = arrayBillListByShop
                        }
                        else
                        {
                            self.arrUserLBillsByShop = [UserLatestBillModel]()
                        }
                        
                        
                        DispatchQueue.main.async {
                            self.receiptTableView.reloadData()
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
