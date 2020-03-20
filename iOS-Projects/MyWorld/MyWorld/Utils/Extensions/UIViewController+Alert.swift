//
//  UIViewController+Alert.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//

/**
 This extension is generated from UIViewController which shows Alert
 
 - parameter message: Alert message which developer wanted to show.
 
 # Notes: #
 1. Alert will show OK button with Alert title Error
 
 */
import UIKit

extension UIViewController{
    //Dismiss alert in 0.6 seconds
    fileprivate func dismissAlert(_ alertController: UIAlertController) {
        let when = DispatchTime.now() + 0.6
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlert(withMessage message:String){
        let alertController = UIAlertController(title: "My World", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        dismissAlert(alertController)
    }
}
