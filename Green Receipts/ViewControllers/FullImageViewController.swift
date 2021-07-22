//
//  FullImageViewController.swift
//  Green Receipts
//
//  Created by Mansur on 17/04/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit

class FullImageViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var fullImageView: UIImageView!
    
    var strImageUrl = ""
    var strReceiptDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backClicked(tapGestureRecognizer:)))
        self.imgViewBack.isUserInteractionEnabled = true
        self.imgViewBack.addGestureRecognizer(backButtonTapGestureRecognizer)
        if let imgBack = UIImage(named: "ic_cross")
        {
            self.imgViewBack.image = imgBack.withRenderingMode(.alwaysTemplate)
            self.imgViewBack.tintColor = AppColor.appMainGreyColor
        }
        
        self.lblHeaderTitle.textColor = UIColor.black
        self.lblHeaderTitle.font = UIFont(name: kAppBoldFont, size: 20.0)
        self.separatorView.backgroundColor = AppColor.appMainGreyColor
        
        if self.strImageUrl != "" {
            let imageURL = kAppwebURl + self.strImageUrl
            self.fullImageView.sd_setImage(with:URL(string: imageURL), placeholderImage:UIImage(named:"ic_CaptureCamera"))
        }
        
        if self.strReceiptDate != "" {
            self.lblHeaderTitle.text = self.strReceiptDate
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        CommonUtility().addShadowToViewBounds(view: self.separatorView, shadowColor: .black, ShadowOpacity: 1.0, shadowOffset: CGSize(width: 0.0, height: 10), ShadowRadius: 10)
    
    }

    // MARK: - Button Actions

    @objc func backClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
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
