//
//  Extensions.swift
//  Sika
//
//  Created by KWAME DARKO on 10/7/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import Foundation


extension UIViewController {
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    

}


extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let pushnotifi = Notification.Name("pushnotifi")
    static let refreshData = Notification.Name("refreshData")


}
