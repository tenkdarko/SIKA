//
//  RequestPayoutViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/12/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class RequestPayoutViewController: UIViewController {
    
    
    @IBOutlet var chooseAmountLabe: UILabel!
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet var emailField: TextfieldNice!
    
    @IBOutlet var selectorView: UIPickerView!
    
    
    
    var behavior: MSCollectionViewPeekingBehavior!

    let payments = ["Paypal", "Amazon", "Starbucks"]
    let amount = ["5","10","25"]
    let coinsEqual = ["5,000 Coins","10,000 Coins","25,0000 Coins"]
    var chosenAmount = "5"
    var chosenPayment = "Paypal"

    let awsRequest = AwsRequests.singleton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        behavior = MSCollectionViewPeekingBehavior()
        
        collectionView2.configureForPeekingBehavior(behavior: behavior)
        
        awsRequest.updateInfoDelegate = self
        

        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        selectorView.delegate = self
        selectorView.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               view.addGestureRecognizer(tap)
        
        initToolbar()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let coinsAvailable = GlobalVariables.singleton.userInfo.rewards
        
        chooseAmountLabe.text = "Choose Amount: \(coinsAvailable) Available Coins"
    }


    
    //MARK: ADD DONE BUTTON TO KEYBOARD
    func initToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        emailField.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func cashOut(_ sender: Any) {
        
        print("before payment sent \(GlobalVariables.singleton.userInfo.uuid) --- \("5")")
        

        print("chosen --- \(chosenPayment) ---- \(chosenAmount)")
        
        var email = ""
        
        if emailField.text!.isEmpty{
            self.showAlert(title: "Email Required", message: "Please input the email for payment")
            return
        }
        
        email = emailField.text!
        
        if chosenPayment.isEmpty {
            self.showAlert(title: "Payment Type", message: "Please choose a payment type")
            return
        }
        
        
        if chosenAmount == "5" && GlobalVariables.singleton.userInfo.rewards < 5000 {
            self.showAlert(title: "Need More Coins", message: "Not enough coins available for cash out $5. Please fill out more surveys")
            return
        }
        
        if chosenAmount == "10" && GlobalVariables.singleton.userInfo.rewards < 10000 {
            print("this is chosen amount \(chosenAmount)")
            print("this is chosen amount \(chosenPayment)")

            self.showAlert(title: "Need More Coins", message: "Not enough coins available for cash out $10. Please fill out more surveys")
            return
        }
        
        if chosenAmount == "25" && GlobalVariables.singleton.userInfo.rewards < 25000 {
            self.showAlert(title: "Need More Coins", message: "Not enough coins available for cash out $25. Please fill out more surveys")
            return
        }
        
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Sending", message: "$\(chosenAmount) - \(chosenPayment) to \(email)", preferredStyle: .alert)

//        //2. Add the text field. You can configure it however you need.
//        alert.addTextField { (textField) in
//            textField.text = "Verify your password"
//        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.callAwsCashOut(email: email, password: "none")
        }))
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    func callAwsCashOut(email: String, password: String){
        awsRequest.cashOut(uniqueID: GlobalVariables.singleton.userInfo.uuid, cashOutValue: chosenAmount, email: email, paymentType: chosenPayment, password: password) { (value) in
            print("PAYMENT SENT \(value)")
            
            if value == -100 {
                print("internal error")
                self.showAlert(title: "Not enough coins", message: "You need more coins to submit a payment request. Please complete more surveys")
            }else if value == 200 {
                self.showAlert(title: "Success", message: "Payment was succesfully sent. Please allow up to 3 full working business days")
            } else{
                self.showAlert(title: "Something went wrong", message: "Please message us on IG @ sikacoins")

            }
        }
    }
    
}



extension RequestPayoutViewController: UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        chosenPayment = payments[row]
        print("this is chosenPayment \(chosenPayment)")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return payments[row]
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView2 {
            return amount.count
        }else{
            return payments.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("'YEEEET'")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PaymentCollectionViewCell
        
            cell.layer.cornerRadius = 10
                 
            cell.label.text = "$\(amount[indexPath.row])"
            cell.coinsEqual.text = coinsEqual[indexPath.row]
            cell.shadowDecorate()
        return cell
    }
}

extension RequestPayoutViewController: UICollectionViewDelegate, updateUserInfo {
    func updateInfo() {
        self.chooseAmountLabe.text = "Choose Amount: \(GlobalVariables.singleton.userInfo.rewards) Available Coins"
    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        print("ending ending endring")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print(behavior.currentIndex)

//        chosenPayment = payments[behavior.currentIndex]
        chosenAmount = amount[behavior.currentIndex]
        
    }
}


extension UICollectionViewCell {
func shadowDecorate() {
    // cell rounded section
     self.layer.cornerRadius = 15.0
     self.layer.borderWidth = 5.0
     self.layer.borderColor = UIColor.clear.cgColor
     self.layer.masksToBounds = true
     
     // cell shadow section
     self.contentView.layer.cornerRadius = 15.0
     self.contentView.layer.borderWidth = 5.0
     self.contentView.layer.borderColor = UIColor.clear.cgColor
     self.contentView.layer.masksToBounds = true
     self.layer.shadowColor = UIColor.black.cgColor
     self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
     self.layer.shadowRadius = 6.0
    self.layer.shadowOpacity = 0.5
     self.layer.cornerRadius = 15.0
     self.layer.masksToBounds = false
     self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
}
}









