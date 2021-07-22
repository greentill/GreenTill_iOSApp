//
//  BaseViewController.swift
//  Green Receipts
//
//  Created by Mansur on 17/11/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

typealias AlertCompletion = (() -> Void)

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showAlertWithMessageWithTitle(title:String, message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert,animated: true)
        }
    }
    func showAlertWithMessageWithCompletion(title:String, message:String, completion: @escaping AlertCompletion ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(UIAlertAction) in
                
                completion()
            }))
            self.present(alert,animated: true)
        }
    }
    func addBackButtonWithTitle(title:String) {
        
        if let imgBack = UIImage(named: "ic_BackArrow")
        {
            self.navigationController?.navigationBar.backIndicatorImage = imgBack

            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack

//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
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
extension UIColor {
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
