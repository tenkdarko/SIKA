//
//  BalanceViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/11/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit
import UIWaveView
import SOTabBar
import FirebaseCore
import FirebaseMessaging

class BalanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var activityind : UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    private var adgateMedia: AdGateMedia?
    var rewardCode = "n6ibqQ"
    var userId = GlobalVariables.singleton.userInfo.uuid


    fileprivate var waterView: UIWaveView = UIWaveView()
        
    @IBOutlet weak var topHeader: UINavigationBar!
    @IBOutlet var requestPayment: RoundButton!
    @IBOutlet weak var userTable: UITableView!
    @IBOutlet weak var bottomView: UIView!
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
    
        if sender.titleLabel?.text == "Learn More" {
            self.performSegue(withIdentifier: "showInvite", sender: nil)
        }else if sender.titleLabel?.text == "Follow"{

            let instURL: NSURL = NSURL (string: "instagram://user?username=sikacoins")! // Replace = Instagram by the your instagram user name
            let instWB: NSURL = NSURL (string: "https://instagram.com/sikacoins/")! // Replace the link by your instagram weblink

            if (UIApplication.shared.canOpenURL(instURL as URL)) {
                    // Open Instagram application
                UIApplication.shared.open(URL(string: "\(instURL)")!)

                } else {
                    // Open in Safari
                UIApplication.shared.open(URL(string: "\(instWB)")!)

                }
            
        }
        
        
    }
    
    
    @IBAction func showCoins(_ sender: Any) {
//        earnCoinsAdgate()
        self.tabBarController?.selectedIndex = 1
    }
    
//    func earnCoinsAdgate(){
//          if adgateMedia == nil {
//               adgateMedia = AdGateMedia(rewardCode: rewardCode, userId: userId, parentViewController: self)
//                       print("addg is nill")
//           } else {
//               adgateMedia?.strRewardCode = rewardCode
//               adgateMedia?.strUserId = userId
//                       print("addg is goood")
//           }
//
//
//           showOfferwall()
//      }
//
//      func showOfferwall(){
//
//          var dictParameters = [String:String]()
//
//          print("loading rlll \(GlobalVariables.singleton.userInfo.referredBy)")
//
//          dictParameters["s2"] = GlobalVariables.singleton.userInfo.referredBy
//
//          let success = adgateMedia?.loadOfferWall(dictParameters, onOfferWallLoadSuccess: {
//              print("Load Success")
//
//          }, onOfferWallLoadFailed: { error in
//
//              print("failed to load wall \(error.localizedDescription)")
//              let alert = UIAlertController(title: "Error: Message us on IG Please", message:
//                  error.localizedDescription, preferredStyle: .alert)
//              let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
//              })
//              alert.addAction(defaultAction)
//              self.present(alert, animated: true)
//          })
//
//          if let success = success, success == true {
//              adgateMedia?.showOfferWall({
//                  print("Closed wall")
//              })
//          }
//      }
//
//
    
    
    
    let awsRequest = AwsRequests.singleton
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if indexPath.row == 0 {
            
         let cell = tableView.dequeueReusableCell(withIdentifier: "summary", for: indexPath) as! summaryTableViewCell
            
                        
            cell.total.text = "\(GlobalVariables.singleton.userInfo.totalrewards) Coins"
            cell.withdrawn.text = "\(GlobalVariables.singleton.userInfo.withdrawn) Coins"
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! walletTableViewCell
        
        
        switch indexPath.row {
        case 1:
            cell.imageHere.image = UIImage(named: "invitefriends")
            cell.labelHeader.text = "Passive Earnings"
            cell.labelMessage.text = "Earn while chilling!"
            cell.buttonLink.setTitle("Learn More", for: .normal)
        case 2:
            cell.imageHere.image = UIImage(named: "instagram")
            cell.labelHeader.text = "Follow Us"
            cell.labelMessage.text = "For rewards / giveaways"
            cell.buttonLink.setTitle("Follow", for: .normal)
        default: break
            
        }
     
        return cell
    }
    
    
    
    
    @objc func pushNotification(){
        print("hehh llllllll")
        userTable.reloadData()
        
    }
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Start wave
        
        userTable.delegate = self
        userTable.dataSource = self
        
        self.userTable.tableFooterView = UIView(frame: CGRect.zero)
        
        
        activityind.center = self.view.center
        activityind.hidesWhenStopped = true
        activityind.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityind)
        activityind.startAnimating()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotification), name: .didReceiveData, object: nil)
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        awsRequest.getUserInfo(uniqueID: GlobalVariables.singleton.userInfo.uuid) { (result) in
            print("got response...")
            
            
            
            NotificationCenter.default.post(name: .pushnotifi, object: nil)

            
            
            self.activityind.stopAnimating()

            self.waterView.start()
            self.timerUpdateProgress()
            self.userTable.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.waterView.overView?.removeFromSuperview()
    }
        
        private func timerUpdateProgress() {
            let p: Float = 15
            self.waterView.progress = p
            self.waterView.color = UIColor(r: 90, g: 200, b: 250)
            self.waterView.borderColor = UIColor(r: 90, g: 200, b: 250)
            
            let label = UILabel(frame: CGRect(x: 90, y: 90, width: 200, height: 200))
            label.textAlignment = .center
            label.text = "\(GlobalVariables.singleton.userInfo.rewards) Coins"
            label.font = UIFont(name: "Nunito-Bold", size: 17.0)
            label.textColor = UIColor.lightGray
            
            self.waterView.overView?.tag = 100

            self.waterView.addOverView(label)

        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0;//Choose your custom row height
    }
    
    
    @objc func onDidReceiveData(_ notification:Notification) {
        userTable.reloadData()
        self.timerUpdateProgress()
    }
 

}


// MARK: View
extension BalanceViewController {
    
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        
        waterView.layer.cornerRadius = 100
        waterView.layer.masksToBounds = true
        waterView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add WaveView
        self.view.addSubview(waterView)
        
        // set visual
        let constraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[v(200)]",
            options: [],
            metrics: nil,
            views: ["v": waterView])

        let constraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[v(200)]",
            options: [],
            metrics: nil,
            views: ["v": waterView])

        let constraintCenterYs = [NSLayoutConstraint(
            item: waterView,
            attribute: .top, relatedBy: .equal,
            toItem: topHeader, attribute: .top,
            multiplier: 1.0, constant: 85)]

        let constraintCenterXs = [NSLayoutConstraint(
            item: waterView,
            attribute: .centerX, relatedBy: .equal,
            toItem: view, attribute: .centerX,
            multiplier: 1.0, constant: 0.0)]
        
        let bottom = [NSLayoutConstraint(
            item: waterView,
            attribute: .bottom, relatedBy: .equal,
            toItem: bottomView, attribute: .top,
            multiplier: 1.0, constant: 0.0)]

        self.view.addConstraints(constraintCenterXs)
        self.view.addConstraints(constraintCenterYs)
        self.view.addConstraints(constraintH)
        self.view.addConstraints(constraintV)
        self.view.addConstraints(bottom)

    }
}
