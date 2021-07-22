//
//  LibraryCell.swift
//  Green Receipts
//
//  Created by Mansur on 21/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {
    @IBOutlet weak var shadowConatinerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var receiptContainerView: UIView!
    @IBOutlet weak var imgReceiptView: UIImageView!
    @IBOutlet weak var cameraRollView: UIView!
    @IBOutlet weak var lblCameraRoll: UILabel!
    @IBOutlet weak var imgViewCalender: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgViewPin: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if let imgReceipt = UIImage(named: "ic_Receipt")
        {
            self.imgReceiptView.image = imgReceipt.withRenderingMode(.alwaysTemplate)
            self.imgReceiptView.tintColor = UIColor.black
        }
        
        if let imgPin = UIImage(named: "ic_pin")
        {
            self.imgViewPin.image = imgPin.withRenderingMode(.alwaysTemplate)
            self.imgViewPin.tintColor = AppColor.appMainGreyColor
        }
        
        if let imgCalendar = UIImage(named: "ic_calendar")
        {
            self.imgViewCalender.image = imgCalendar.withRenderingMode(.alwaysTemplate)
            self.imgViewCalender
                .tintColor = AppColor.appMainGreyColor
        }
        
        self.lblCameraRoll.textColor = UIColor.white
        self.lblCameraRoll.font = UIFont(name: kAppBoldFont, size: 16)
        self.cameraRollView.backgroundColor = AppColor.appGreenColor
        self.lblDate.textColor = AppColor.appMainGreyColor
        self.lblDate.font = UIFont(name: kAppRegularFont, size: 16)
        self.lblLocation.textColor = AppColor.appMainGreyColor
        self.lblLocation.font = UIFont(name: kAppRegularFont, size: 16)
        
        
        
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
