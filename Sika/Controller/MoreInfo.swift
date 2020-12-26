//
//  AccountViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/11/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit
import AdGateMedia


class MoreInfo: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var uuidLabel: UILabel!
    

    
    let awsRequest = AwsRequests()
    
    var infoCells = ["FAQ", "Privacy Policy", "Terms of Service"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoCells.count
    }
    
    
    
    @IBAction func trueCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
        cell.label.text = infoCells[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "faq", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "privacy", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "tos", sender: nil)
        default:
            break
        }
    }
    

    @IBOutlet weak var infoTable: UITableView!
    
    @IBOutlet weak var topData: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoTable.delegate = self
        infoTable.dataSource = self
        
        topData.layer.borderWidth = 1
         topData.layer.cornerRadius = 5
         topData.layer.borderColor = UIColor.init(r: 204, g: 204, b: 204).cgColor
        
        
        infoTable.layer.borderWidth = 1
        infoTable.layer.cornerRadius = 5
        infoTable.layer.borderColor = UIColor.init(r: 204, g: 204, b: 204).cgColor
        self.infoTable.tableFooterView = UIView(frame: CGRect.zero)
        
        
        uuidLabel.text = GlobalVariables.singleton.userInfo.uuid
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("everything \(GlobalVariables.singleton.userInfo.uuid)")
        uuidLabel.text = GlobalVariables.singleton.userInfo.uuid

        print("user \(GlobalVariables.singleton.userInfo)")
    }
    
    
    
    @IBAction func deleteAccount(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete my account", message: "We will delete all your data and information. This will also delete your account including your earnings. Please confirm this again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in

            self.awsRequest.deleteAccount(uniqueID: GlobalVariables.singleton.userInfo.uuid) { (result) in
                print("xthis is falseeee")
                
                let defaults = UserDefaults()
                defaults.removeObject(forKey: "uniqueId")
                
                self.performSegue(withIdentifier: "makedecision", sender: nil)
                
            }
            
        }))
        
        
        self.present(alert, animated: true)

    }
    
    //more info

}
