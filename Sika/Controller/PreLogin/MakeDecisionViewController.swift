//
//  MakeDecisionViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/10/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class MakeDecisionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let result = UserDefaults()
         
        if result.string(forKey: "uniqueId") != nil {
            
            print("uniqueiddddd \(result.string(forKey: "uniqueId")!)")
            
            GlobalVariables.singleton.userInfo.uuid = result.string(forKey: "uniqueId")!
            self.performSegue(withIdentifier: "goToMain", sender: nil)
        }else{
            print("we in get started")
            self.performSegue(withIdentifier: "getStarted", sender: nil)
        }
    }

}
