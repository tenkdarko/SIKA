//
//  InvitationCodeViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 8/10/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class InvitationCodeViewController: UIViewController, UITextFieldDelegate {

    let awsRequest = AwsRequests()
    let uuid = ""
    
    @IBOutlet var topRightButton: UIBarButtonItem!
    @IBOutlet var userName: TextfieldNice!
    @IBOutlet weak var password: TextfieldNice!
    @IBOutlet var confirmPassword: TextfieldNice!
    @IBOutlet var inviteCode: TextfieldNice!
    @IBOutlet var continueButton: RoundButton!
    
    
    
    
    
    @IBAction func skipButton(_ sender: Any) {
        
        print("login clicked")
        
        
        if topRightButton.title == "Login" {
            confirmPassword.isHidden = true
            inviteCode.isHidden = true
            topRightButton.title = "Register"
            continueButton.setTitle("login", for: .normal)

        }else if topRightButton.title == "Register" {
            confirmPassword.isHidden = false
            inviteCode.isHidden = false
            continueButton.setTitle("Register", for: .normal)
            topRightButton.title = "Login"
        }
        

    }
    
    
    func showAllTextfields(){
        
        if topRightButton.title == "Register" {
            userName.isHidden = false
            password.isHidden = false
            confirmPassword.isHidden = true
            inviteCode.isHidden = true
        }else{
            userName.isHidden = false
            password.isHidden = false
            confirmPassword.isHidden = false
            inviteCode.isHidden = false
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                     view.addGestureRecognizer(tap)
              
              initToolbar()
        
        userName.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        inviteCode.delegate = self
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    
    
    @IBAction func continueRef(_ sender: UIButton) {
        
        guard let usernameUser = userName.text?.lowercased(), userName.text?.count != 0 else {
            self.showAlert(title: "Username", message: "Please input a username")
            return
        }
        
        print("heeeee \(usernameUser)")
        
        guard let passwordUser = password.text, password.text?.count != 0 else {
            self.showAlert(title: "Password", message: "Can not be empty")
            return
        }
        
        if continueButton.currentTitle == "Register" {
        
        var referralBy = ""
        

        
        guard let confirmPass = confirmPassword.text, confirmPassword.text?.count != 0 else {
            self.showAlert(title: "Confirm password", message: "can not be empty")
            return
        }
        
        
        
        if inviteCode.text?.count == 0 {
           referralBy = ""
        } else {
            referralBy = inviteCode.text!
            referralBy = referralBy.trimmingCharacters(in: CharacterSet.whitespaces)
        }
        
        
        if confirmPass != passwordUser {
            self.showAlert(title: "Different password", message: "The passwords you inputted don't match")
            return
        }
        
        
        

            awsRequest.registerUser(uniqueID: usernameUser, referredBy: referralBy, password: passwordUser) { (result) in
                                
                
                if result == "true" {
                    
                    let userId = UserDefaults()
                    userId.setValue(usernameUser, forKey: "uniqueId")
                    
                    GlobalVariables.singleton.userInfo.uuid = usernameUser
                    
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                    
                }else if result == "invalidcode"{
                    print("zin is nooooo")
                    self.showAlert(title: "Invalid Invitation Code", message: "The code you used is invalid")
                } else if result == "takenusername"{
                    self.showAlert(title: "Username Taken", message: "Please use a different username")
                }else{
                    self.showAlert(title: "Something went wrong", message: "Appears something went wrong. Please message us on Instagram @sikacoins or email sikacoinsapp@gmail.com")
                }
            }
        }else{
            awsRequest.loginToApp(uniqueID: usernameUser, password: passwordUser) { (result) in
                if result == "true"{
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                } else if result == "error" {
                           self.showAlert(title: "Something went wrong", message: "Appears something went wrong. Please message us on Instagram @sikacoins or email sikacoinsapp@gmail.com")
                }
                else{
                    self.showAlert(title: "Invalid", message: "USERNAME: \(usernameUser) & PASSWORD: \(passwordUser) is wrong")
                }
            }
        }
        

    }
    
    
    
    //MARK: ADD DONE BUTTON TO KEYBOARD
    func initToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        userName.inputAccessoryView = toolBar
        confirmPassword.inputAccessoryView = toolBar
        password.inputAccessoryView = toolBar
        inviteCode.inputAccessoryView = toolBar



    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        showAllTextfields()
    }
    
    

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showAllTextfields()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("we are in delllll")
        
        if textField == userName{
            password.isHidden = true
            confirmPassword.isHidden = true
            inviteCode.isHidden = true
        }else if textField == password {
            userName.isHidden = true
            confirmPassword.isHidden = true
            inviteCode.isHidden = true
        }else if textField == confirmPassword {
            password.isHidden = true
            userName.isHidden = true
            inviteCode.isHidden = true
        }else if textField == inviteCode {
            password.isHidden = true
            userName.isHidden = true
            confirmPassword.isHidden = true
        }
    }

}
