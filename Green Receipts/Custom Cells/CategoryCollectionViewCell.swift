//
//  CategoryCollectionViewCell.swift
//  Green Receipts
//
//  Created by Mansur on 30/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var lblCategorytype: UILabel!
    @IBOutlet weak var lblTotalReceipt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containerView.backgroundColor = AppColor.appGreenColor
        
        
        self.lblCategorytype.textColor = UIColor.white
        self.lblTotalReceipt.textColor = UIColor.white
        self.lblCategorytype.font = UIFont(name: kAppBoldFont, size: 16.0)
        self.lblTotalReceipt.font = UIFont(name: kAppRegularFont, size: 15.0)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        CommonUtility().addRoundCorners(view: self.containerView, radius: 20)
          CommonUtility().addRoundCorners(view: self.shadowContainerView, radius: 20)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            CommonUtility().addShadowToView(view: self.shadowContainerView, ShadowColor: AppColor.appMainGreyColor, ShadowOpacity: 0.5, shadowOffset: CGSize(width: 0.0, height: 5.0), ShadowRadius: 5.0)
        }
    }
}
