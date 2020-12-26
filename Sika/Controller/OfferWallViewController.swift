//
//  OfferWallViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/10/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit
import AdGateMedia

class OfferWallViewController: UIViewController {

    private var adgateMedia: AdGateMedia?
    
    
    
    
    @IBOutlet var monetTablel: UITableView!
    
    
    
    var rewardCode = "n6ibqQ"
    var userId = GlobalVariables.singleton.userInfo.uuid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monetTablel.delegate = self
        monetTablel.dataSource = self
        // Do any additional setup after loading the view.
        
        self.monetTablel.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    
    @IBAction func goToInvite(_ sender: Any) {
        self.performSegue(withIdentifier: "invite", sender: nil)
    }
    

    
    @IBAction func EarnCoins(_ sender: Any) {

        if adgateMedia == nil {
             adgateMedia = AdGateMedia(rewardCode: rewardCode, userId: userId, parentViewController: self)
         } else {
             adgateMedia?.strRewardCode = rewardCode
             adgateMedia?.strUserId = userId
         }
         
         
         showOfferwall()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        monetTablel.reloadData()
    }
    

    
    func showOfferwall(){
        
        var dictParameters = [String:String]()
                
        dictParameters["s2"] = GlobalVariables.singleton.userInfo.referredBy

        let success = adgateMedia?.loadOfferWall(dictParameters, onOfferWallLoadSuccess: {
            print("Load Success")

        }, onOfferWallLoadFailed: { error in
            
            let alert = UIAlertController(title: "Error", message:
                error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        })

        if let success = success, success == true {
            adgateMedia?.showOfferWall({
                print("Closed wall")
            })
        }
    }
    
    

}

extension OfferWallViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.singleton.userInfo.inviteDetailed.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "referralCell", for: indexPath) as! ReferralCell
               
                
               cell.coinsMade.text = "9000 Coins"

               cell.youInvited.text = "Example123"
            
            cell.coinsMade.textColor = UIColor.lightGray
               cell.youInvited.textColor = UIColor.lightGray

               
                    return cell
        }
        
        if indexPath.row == GlobalVariables.singleton.userInfo.inviteDetailed.count+1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "invite", for: indexPath)

                 return cell
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "referralCell", for: indexPath) as! ReferralCell
        
         
        cell.coinsMade.text = "\(GlobalVariables.singleton.userInfo.inviteDetailed[indexPath.row-1]["points"].stringValue) Coins"

        cell.youInvited.text = GlobalVariables.singleton.userInfo.inviteDetailed[indexPath.row-1]["name"].stringValue
        
        
             return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "referralHeader")

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("index path cvhosen \(indexPath.row)")
        
        if indexPath.row == 0 {
            EarnCoins("nil")
        } else if indexPath.row == 1 {
            self.performSegue(withIdentifier: "invite", sender: nil)
        }else{
            return
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 70;//Choose your custom row height
        }else if indexPath.row == GlobalVariables.singleton.userInfo.inviteDetailed.count+1 {
            return 175;//Choose your custom row height
        }else{
            return 70
        }
     }
    
    
}
