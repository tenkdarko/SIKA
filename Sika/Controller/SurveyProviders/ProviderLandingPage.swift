//
//  ProviderLandingPage.swift
//  ProviderLandingPage
//
//  Created by K on 8/18/21.
//  Copyright © 2021 KWAME DARKO. All rights reserved.
//

import UIKit
import InBrainSurveys_SDK_Swift



class ProviderLandingPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userId = GlobalVariables.singleton.userInfo.uuid
    private var adgateMedia: AdGateMedia?
    let inBrain: InBrain = InBrain.shared
    let aws = AwsRequests.singleton
    var activityind : UIActivityIndicatorView = UIActivityIndicatorView()

    
    func startActivity(){
        activityind.center = self.view.center
        activityind.hidesWhenStopped = true
        activityind.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityind)
        activityind.startAnimating()
    }
    
    @IBOutlet weak var providerTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        print("aHELO WORLD HAHAHAHA")
        startActivity()
        aws.dailyRewards(uniqueID: userId) { result in
            if result == "true"{
                self.showAlert(title: "Coins Added", message: "20 coins has been added to your account.")
                self.activityind.stopAnimating()

            }else if result == "false" {
                self.showAlert(title: "Coins Already Redeemed", message: "Come back tomorrow to redeem coins again")
                self.activityind.stopAnimating()
            }
            else{
                self.showAlert(title: "Oh no...", message: "Something went wrong. Please messaage us on instagram")
                self.activityind.stopAnimating()
            }
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! walletTableViewCell
            
            cell.imageHere.image = UIImage(named: "icons8-calendar-4")
            cell.labelHeader.text = "Attendence Rewards"
            cell.labelMessage.text = "Check-in Daily"
            cell.buttonLink.setTitle("+20 FREE", for: .normal)
            
            cell.selectionStyle = .none
            
            return cell
        }else{
        
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
        
            if indexPath.row == 1 {
                cell.providerImage.image = UIImage(named: "inbrainLogo")
            }else {
                cell.providerImage.image = UIImage(named: "adgateMedia")
            }
        

        return cell
        }
        
        
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            return
        case 1:
            startActivity()
            showInBrain("nil")
        case 2:
            loadAdgateMedia()
        default:
            return
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.providerTable.deselectSelectedRow(animated: true)
    }
    
    
    @IBOutlet weak var providerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        providerTable.delegate = self
        providerTable.dataSource = self
        loadInbrainSurveys()
        // Do any additional setup after loading the view.
        self.providerTable.tableFooterView = UIView(frame: CGRect.zero)

    }
    
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
//        startActivity()
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
        if indexPath.row == 0 {
            return 70
        }else {
            return 125.0;//Choose your custom row height
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
