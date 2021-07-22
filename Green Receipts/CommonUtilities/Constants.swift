//
//  Constants.swift
//  Green Receipts
//
//  Created by Mansur on 11/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

let kAppBoldFont: String = "Cavolini-Bold"
let kAppRegularFont: String = "Cavolini-Regular"

let kAppBaseURL: String = "http://greentill.ie/greenTill/ws_mobile/"
let kAppwebURl: String = "http://greentill.ie/greenTill/"
let kGoogleInfoURl: String = "https://www.googleapis.com/oauth2/v3/userinfo?access_token="
let kForgotPasswordOTP:String = "2348"


class Constants: NSObject {

}

struct AppRoundedTheme {
    static let roundedCornerRadiusForContainer: CGFloat = 15.0
    static let roundedCornerRadiusForButtons: CGFloat = 5.0
}

struct AppColor {
    
    static let appGreenColor = UIColor.init(red: 62.0/255.0, green: 184.0/255.0, blue: 62.0/255.0, alpha: 1.0)
    static let appMainGreyColor = UIColor.init(red: 114.0/255.0, green: 114.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    static let appRedColor = UIColor.init(red: 244.0/255.0, green: 70.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    static let appDarkPinkColor = UIColor.init(red: 218.0/255.0, green: 0.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    static let appLightPinkColor = UIColor.init(red: 221.0/255.0, green: 66.0/255.0, blue: 122.0/255.0, alpha: 1.0)
    static let appLightWhiteColor = UIColor.init(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    static let appLimeGreenColor = UIColor.init(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let appBlueColor = UIColor.init(red: 0.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}
