//
//  ProviderLandingPage.swift
//  ProviderLandingPage
//
//  Created by K on 8/18/21.
//  Copyright © 2021 KWAME DARKO. All rights reserved.
//

import UIKit
import InBrainSurveys_SDK_Swift

import StoreKit


class ProviderLandingPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userId = GlobalVariables.singleton.userInfo.uuid
    private var adgateMedia: AdGateMedia?
    let inBrain: InBrain = InBrain.shared
    let aws = AwsRequests.singleton
    var activityind : UIActivityIndicatorView = UIActivityIndicatorView()

    var timer: Timer!
    var endTime: Date?
    
        
    
    let setRedeemTimerUserId = UserDefaults.standard
    
    @IBOutlet weak var providerTable: UITableView!
    @IBOutlet weak var redeemCoinButton: RoundButton!
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    @IBOutlet weak var rateUs: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        providerTable.delegate = self
        providerTable.dataSource = self
        loadInbrainSurveys()
        
        startClock()
                
        // Do any additional setup after loading the view.
        self.providerTable.tableFooterView = UIView(frame: CGRect.zero)

        
        
        if GlobalVariables.singleton.userInfo.ratedApp {
            rateUs.isHidden = true
        }
                
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.providerTable.deselectSelectedRow(animated: true)
        
    }
    
    func startActivity(){
        activityind.center = self.view.center
        activityind.hidesWhenStopped = true
        activityind.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityind)
        activityind.startAnimating()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    //It takes 1 minute and will help grow the community and provide better tasks.
    // We put our hearts and soul into this app to bring you the best surveys.
    
    
    @IBAction func rateTheApp(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Rate $IKA 5 stars", message: "Rate $IKA 5 stars in the App Store & get rewarded 100 Coins!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Rate", style: .default, handler: { (normal) in
            
            let instURL: NSURL = NSURL (string: "itms-apps://itunes.apple.com/app/id1535149985?action=write-review")! // Replace = Instagram by the your instagram user name
            let instWB: NSURL = NSURL (string: "https://apps.apple.com/app/id1535149985?action=write-review")! // Replace the link by your instagram weblink

            if (UIApplication.shared.canOpenURL(instURL as URL)) {
                    // Open Instagram application
                UIApplication.shared.open(URL(string: "\(instURL)")!)
                } else {
                    // Open in Safari
                UIApplication.shared.open(URL(string: "\(instWB)")!)
                }
            
            self.aws.rateApp(uniqueID: self.userId) { (val) in
                print("KWAME VAL MANNNN")
                self.rateUs.isHidden = true
                self.showAlert(title: "COINS CREDITED", message: "Your account was credited 100 coins")
            }
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (normal) in
            
            
        }))
        
        
        self.present(alert, animated: true)        
    }
    
    
    
    func startClock(){
        let date = UserDefaults.standard.object(forKey: "setRedeemTimer") as? Date

         
        if date != nil {
            
            print("KWAME WE SETTTT")

            
            endTime = date
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
            
        }else{
            print("KWAME WE NOT SET")
            
            redeemCoinButton.setTitle("+20 Coins!", for: .normal)
            redeemCoinButton.isEnabled = true
        }
        
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        print("aHELO WORLD HAHAHAHA")
        

        redeemCoinButton.isEnabled = false
        startClock()
        
        startActivity()
        aws.dailyRewards(uniqueID: userId) { result in
            if result == "true"{
                self.showAlert(title: "Coins Added", message: "20 coins has been added to your account. Make sure to follow our Instagram for private giveaways @sikacoins")
                self.activityind.stopAnimating()
                
                let nowDate = GlobalVariables.singleton.awsExpiredTimestamp!
                
                self.endTime = Calendar.current.date(byAdding: .day, value: 1, to: nowDate)!
                
                self.setRedeemTimerUserId.set(self.endTime as! NSCoding, forKey: "setRedeemTimer")

                self.startClock()

            }else if result == "false" {
                self.showAlert(title: "Coins Already Redeemed", message: "Come back tomorrow to redeem coins again. Make sure to follow our Instagram for private giveaways @sikacoins")
                self.activityind.stopAnimating()
                let nowDate = GlobalVariables.singleton.awsExpiredTimestamp!
                
                self.endTime = Calendar.current.date(byAdding: .day, value: 1, to: nowDate)!
                
                self.setRedeemTimerUserId.set(self.endTime as! NSCoding, forKey: "setRedeemTimer")
                self.redeemCoinButton.isEnabled = false
                self.startClock()
            }
            else{
                self.showAlert(title: "Oh no...", message: "Something went wrong. Please messaage us on instagram")
                self.activityind.stopAnimating()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "providerCell", for: indexPath) as! ProviderTableViewCell

        
             cell.layer.cornerRadius = 15.0
             cell.layer.borderWidth = 5.0
             cell.layer.borderColor = UIColor.clear.cgColor
        cell.viewProvider.layer.masksToBounds = true
             
             // cell shadow section
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 5.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.viewProvider.layer.shadowColor = UIColor.gray.cgColor
        cell.viewProvider.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.viewProvider.layer.shadowRadius = 15.0
        cell.viewProvider.layer.shadowOpacity = 0.2
        cell.viewProvider.layer.cornerRadius = 15.0
        cell.viewProvider.layer.masksToBounds = false
        cell.viewProvider.layer.shadowPath = UIBezierPath(roundedRect: cell.viewProvider.bounds, cornerRadius: cell
                                                .contentView.layer.cornerRadius).cgPath
        
            if indexPath.row == 0 {
                cell.providerImage.image = UIImage(named: "inbrainLogo")
            }else {
                cell.providerImage.image = UIImage(named: "adgateMedia")
            }
        
        return cell
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            startActivity()
            showInBrain("nil")
            return
        case 1:
            loadAdgateMedia()
        default:
            return
        }
    }
    

    
    
    @IBOutlet weak var providerTableView: UITableView!
    
    
    func loadInbrainSurveys(){
//        startActivity()
        inBrain.setInBrain(apiClientID: "fdbc4795-1e7f-44e1-805e-9b77d754ea09",
                           apiSecret: "lJtb8vI09pcBc5qjG1DHxQU1DSrjSZw9P8HBsdcFeem7L32qlarVXBqfQK9vjvM7HalSwsRZVDh5VeSef57fAA==",
                           isS2S: true)
        inBrain.set(userID: userId)
        inBrain.inBrainDelegate = self
    }
    
    
    func showInBrain(_ sender: Any) {
            inBrain.checkForAvailableSurveys { [weak self] hasSurveys, _  in
                guard hasSurveys else {
                    print("OH LORD NOT AGAIN")
                    self!.activityind.stopAnimating()
                    return }
                
                self!.activityind.stopAnimating()
                self?.inBrain.showSurveys()
            }
        }
    
    
    func loadAdgateMedia(){
        let rewardCode = "n6ibqQ"
        if adgateMedia == nil {
             adgateMedia = AdGateMedia(rewardCode: rewardCode, userId: userId, parentViewController: self)
         } else {
             adgateMedia?.strRewardCode = rewardCode
             adgateMedia?.strUserId = userId
         }
        
        showAdgateMediaOfferwall()
    }
    
    
    func showAdgateMediaOfferwall(){
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 125.0;//Choose your custom row height
        
    }
    
    
    
    @objc func UpdateTime() {
        let userCalendar = Calendar.current
        // Set Current Date
        let date = Date()

        let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: date, to: endTime!)
        // Display Countdown
        
        timeLeftLabel.text = "Time Left: \(timeLeft.hour!)h \(timeLeft.minute!)m \(timeLeft.second!)s"
        
        endEvent(currentdate: date, eventdate: endTime!)
    }
    
    func endEvent(currentdate: Date, eventdate: Date) {
        
        if currentdate >= eventdate {
            
            print("WE IN TRUE HHAHAHA")
            redeemCoinButton.isEnabled = true
            redeemCoinButton.setTitle("+20 Coins!", for: .normal)
            timeLeftLabel.text = "Check in daily"

            redeemCoinButton.backgroundColor = UIColor(r: 254, g: 136, b: 104)

            // Stop Timer
            timer.invalidate()
        }else {
            print("WE IN ELSEEEEE")

            redeemCoinButton.setTitle("Redeemed", for: .disabled)
            redeemCoinButton.backgroundColor = UIColor(r: 204, g: 204, b: 204)
        }
    }
    
    
    
}



extension ProviderLandingPage: InBrainDelegate {
    func nativeSurveysLoadingStarted() {
        return
    }
    
    func nativeSurveysReceived(_ surveys: [InBrainNativeSurvey]) {
        return
    }
    
    func failedToReceiveNativeSurveys(error: Error) {
        return
    }
}


extension UITableView {

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}
