//
//  Flash.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/4.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

extension UIViewController {
    typealias AlertCallback =  ((UIAlertAction) -> Void)
    func flash(title: String, message: String, callback: AlertCallback? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: callback)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
