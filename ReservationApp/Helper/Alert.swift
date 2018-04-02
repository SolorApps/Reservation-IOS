//
//  Alert.swift
//  ReservationApp
//
//  Created by Erick Manrique on 4/2/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    class func showBasic(title:String, message: String, actionTitle: String = "Ok", vc: UIViewController){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default,handler: nil))
        
        DispatchQueue.main.async { [weak vc] in
            vc?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showNetworkError(on vc: UIViewController) {
        showBasic(title: "Opps", message: "something did not go as planned please try again", vc: vc)
    }
}
