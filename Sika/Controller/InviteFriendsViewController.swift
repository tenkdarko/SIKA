//
//  InviteFriendsViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/15/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController {

    
    @IBOutlet var invited: UILabel!
    
    @IBOutlet var referralEarned: UILabel!
    
    
    
    
    @IBOutlet var summaryView: UIView!
    @IBOutlet var referralID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        summaryView.layer.borderWidth = 1
         summaryView.layer.cornerRadius = 5
         summaryView.layer.borderColor = UIColor.init(r: 204, g: 204, b: 204).cgColor
        
        referralID.text = GlobalVariables.singleton.userInfo.uuid
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        referralEarned.text = "\(GlobalVariables.singleton.userInfo.referralrewards) Coins"
        
        invited.text = "\(GlobalVariables.singleton.userInfo.invitedFriends)"
    }
    
    
    
    
    
    @IBAction func trueCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

    
    
    
    
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        
        let alert = UIAlertController(title: "How It Works", message: "Click the share button", preferredStyle: .alert)
    
            
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { (normal) in
            
                let alert2 = UIAlertController(title: "How It Works", message: "Share your username with friends or strangers. Social media platforms are great way to reach more people.", preferredStyle: .alert)
                
            
            
            alert2.addAction(UIAlertAction(title: "Next", style: .default, handler: { (normal) in
                 
                     let alert3 = UIAlertController(title: "How It Works", message: "If they enter your code, you will earn money with each survey they complete FOREVER! Sit back, kickback and collect money.", preferredStyle: .alert)
                     
                 
                 
            
                 
                 
                     alert3.addAction(UIAlertAction(title: "close", style: .destructive, handler: nil))
                      self.present(alert3, animated: true)
                 }))
                
            
            
            alert2.addAction(UIAlertAction(title: "close", style:.destructive, handler: nil))
                 self.present(alert2, animated: true)
            }))
            
  

        alert.addAction(UIAlertAction(title: "close", style: .destructive, handler: nil))


         
         
         self.present(alert, animated: true)
        
    }
    

    @IBAction func shareWithFriends(_ sender: Any) {
        let string = "Download $IKA to earn money doing surveys. With my code you will get $0.30 start bonus! My code is: \(GlobalVariables.singleton.userInfo.uuid) - sikacoinapp.com"
        let url = URL(string: "https://www.sikacoinapp.com")!
        let image = UIImage(named: "sikalogo.png")
      

        let activityViewController =
            UIActivityViewController(activityItems: [string, url, image],
                                     applicationActivities: nil)

  
        present(activityViewController, animated: true, completion: nil)
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
