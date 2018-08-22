//
//  UIViewController+Alert.swift
//  303Test
//
//  Created by Roman on 8/17/18.
//  Copyright © 2018 JetSoftPro. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func makeAlert(_ message: String) {
        let alertController = UIAlertController(title: Constants.alertTitle, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
