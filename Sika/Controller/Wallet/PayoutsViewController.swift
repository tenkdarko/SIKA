//
//  PayoutViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/13/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class PayoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var count = 0
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var paymentTable: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        showEmptyViewOrRegular()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showpayouts", for: indexPath) as! ShowPayoutsTableViewCell
        

        cell.amount.text = "$\(GlobalVariables.singleton.userInfo.payments[indexPath.row]["Amount"].stringValue)"
        
        cell.paymentType.text = GlobalVariables.singleton.userInfo.payments[indexPath.row]["paymentType"].stringValue
        
        cell.email.text = GlobalVariables.singleton.userInfo.payments[indexPath.row]["email"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "payoutHeader") as! PaymentHeaderCell

        return cell
    }
    
    
    func showEmptyViewOrRegular() -> Int{
        if GlobalVariables.singleton.userInfo.payments.isEmpty{
            paymentTable.setEmptyView(title: "No payouts requested yet", message: "The payout history will be displayed here")
            return 0
        }else {
            paymentTable.restore()
            return GlobalVariables.singleton.userInfo.payments.count
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        paymentTable.delegate = self
        paymentTable.dataSource = self
        
        self.paymentTable.tableFooterView = UIView(frame: CGRect.zero)
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


extension UITableView {
    
    func setEmptyView(title: String, message: String) {
        
        
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        emptyView.layer.borderWidth = 1
        emptyView.layer.cornerRadius = 5
        emptyView.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
