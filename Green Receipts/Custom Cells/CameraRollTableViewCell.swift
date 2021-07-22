//
//  CameraRollTableViewCell.swift
//  Green Receipts
//
//  Created by Mansur on 09/04/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit

class CameraRollTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowConatinerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var receiptContainerView: UIView!
    @IBOutlet weak var imgReceiptView: UIImageView!
    @IBOutlet weak var cameraRollView: UIView!
    @IBOutlet weak var lblCameraRoll: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if let imgReceipt = UIImage(named: "ic_Receipt")
        {
            self.imgReceiptView.image = imgReceipt.withRenderingMode(.alwaysTemplate)
            self.imgReceiptView.tintColor = UIColor.black
        }
        
        self.lblCameraRoll.textColor = UIColor.white
        self.lblCameraRoll.font = UIFont(name: kAppBoldFont, size: 16)
        self.cameraRollView.backgroundColor = AppColor.appGreenColor
        
        self.lblCameraRoll.text = "Camera Roll"
        self.lblDescription.text = "Here, you'll get all your uploaded digital Receipts"
        self.lblDescription.textColor = UIColor.darkGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CommonUtility().addRoundCorners(view: self.cameraRollView, radius: 40)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            CommonUtility().addShadowToView(view: self.shadowConatinerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.5, shadowOffset: CGSize(width: 0.0, height: 5.0), ShadowRadius: 5.0)
            CommonUtility().addShadowToView(view: self.receiptContainerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.5, shadowOffset: CGSize(width: 0.0, height: 5.0), ShadowRadius: 5.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
