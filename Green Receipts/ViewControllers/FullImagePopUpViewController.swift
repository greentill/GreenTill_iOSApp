//
//  FullImagePopUpViewController.swift
//  Green Receipts
//
//  Created by Mansur on 08/04/21.
//  Copyright © 2021 MansurBagwan. All rights reserved.
//

import UIKit

class FullImagePopUpViewController: UIViewController {

    @IBOutlet weak var tapToDissmissView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fullImageView: UIImageView!
    
    var strImageUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        
        self.view.backgroundColor = AppColor.appMainGreyColor.withAlphaComponent(0.6)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
        self.tapToDissmissView.addGestureRecognizer(tapGestureRecognizer)
        
        if self.strImageUrl != "" {
            let imageURL = kAppwebURl + self.strImageUrl
            self.fullImageView.sd_setImage(with:URL(string: imageURL), placeholderImage:UIImage(named:"ic_CaptureCamera"))
        }
        
    }
    
    // MARK: - TapGesture Recognizer methods
    @objc func tapToDismiss() {
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
