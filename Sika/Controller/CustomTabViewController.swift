//
//  CustomTabViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/11/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit
import SOTabBar

class CustomTabViewController: SOTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "wallet")
        
            let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "offerwall")
    
            let thirdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showinvitefriends")
        
        
            firstVC.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(named: "icons8-coin-wallet-64"), selectedImage: UIImage(named: "icons8-coin-wallet-64"))
            secondVC.tabBarItem = UITabBarItem(title: "Earn", image: UIImage(named: "payroll"), selectedImage: UIImage(named: "payroll"))
        
            thirdVC.tabBarItem = UITabBarItem(title: "Passive Income", image: UIImage(named: "passive"), selectedImage: UIImage(named: "passive"))
        
            viewControllers = [firstVC, secondVC, thirdVC]

        // Do any additional setup after loading the view.
    }
    
    
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarShadowColor = UIColor(r: 111, g: 152, b: 36).cgColor
        SOTabBarSetting.tabBarTintColor = UIColor(r: 255, g: 255, b: 255)
    }
    


}
