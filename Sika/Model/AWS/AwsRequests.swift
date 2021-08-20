//
//  AwsRequests.swift
//  Sika
//
//  Created by KWAME DARKO on 8/10/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AwsRequests {
    
    static let singleton = AwsRequests()
    
    var updateInfoDelegate: updateUserInfo?
    let register = "https://2v160777d5.execute-api.us-east-1.amazonaws.com/conversions/register"
    let getUserInfo = "https://2v160777d5.execute-api.us-east-1.amazonaws.com/conversions/getUserInfo"
    
    let cashOut = "https://2v160777d5.execute-api.us-east-1.amazonaws.com/conversions/cashout"
    let deleteAccount = "https://2v160777d5.execute-api.us-east-1.amazonaws.com/conversions/deleteaccount"
    let loginToApp = "https://2v160777d5.execute-api.us-east-1.amazonaws.com/conversions/login"
    let dailyRewards = "https://2v160777d5.execute-api.us-east-1.amazonaws.com/conversions/dailyrewards"

    
    let global = GlobalVariables.singleton
    
    func registerUser(uniqueID: String, referredBy: String, password: String, completion: @escaping (String) -> Void){
        let params = ["uniqueID": uniqueID, "referredBy": referredBy, "password": password]
        AF.request(register, parameters: params).responseJSON { (response) in
            if response.response?.headers.dictionary["takenusername"]?.description == "taking" {
                completion("takenusername")
                return
            }
            if response.response?.headers.dictionary["referralcode"]?.description == "invalid" {
                completion("invalidcode")
                return
            }
            if (response.response?.headers.dictionary["account"]) == "created" {
                completion("true")
                return
            }
            completion("error")
        }
    }
    
    
    func loginToApp(uniqueID: String, password: String, completion: @escaping (String) -> Void){
        let params = ["uniqueID": uniqueID, "password": password]
        AF.request(loginToApp, parameters: params).responseJSON { (response) in
            if (response.response?.headers.dictionary["access"]?.description) == "granted" {
                let saveAccountReferralID = UserDefaults.standard
                saveAccountReferralID.set(uniqueID, forKey: "uniqueId")
                GlobalVariables.singleton.userInfo.uuid = uniqueID
                completion("true")
                return
            }
            if (response.response?.headers.dictionary["access"]) == nil {
                completion("error")
                return
            }
            completion("denied")
        }
    }
    
    func dailyRewards(uniqueID: String, completion: @escaping (String) -> Void){
        let params = ["uniqueID": uniqueID]
        AF.request(dailyRewards, parameters: params).responseJSON { (response) in
            if (response.response?.headers.dictionary["dailyrewards"]?.description) == "true" {
                
                completion("true")
                return
            }
            
            if (response.response?.headers.dictionary["dailyrewards"]?.description) == "false" {
                
                completion("false")
                return
            }
            
            if (response.response?.headers.dictionary["access"]) == nil {
                completion("error")
                return
            }
            completion("denied")
        }
    }
    
    
    func getUserInfo(uniqueID: String,completion: @escaping (Bool) -> Void){
        let params = ["uniqueID": GlobalVariables.singleton.userInfo.uuid]
        AF.request(getUserInfo, parameters: params).responseJSON { (response) in
                        
            let info = JSON(response.data)
                        
            guard info["item"] != "null" else{
                completion(false)
                return
            }
            
            let rewards = info["Item"]["rewards"].intValue
            let totalrewards = info["Item"]["totalrewards"].intValue
            let withdrawn = info["Item"]["withdrawnrewards"].intValue
            let referralRewards = info["Item"]["referralrewards"].intValue
            let payments = JSON(info["Item"]["payments"])
            let invite = JSON(info["Item"]["detailedInvited"])
            let referredBy = info["Item"]["referredBy"].stringValue
            let invitedFriends = info["Item"]["invitedFriends"].intValue


            self.global.userInfo.rewards = rewards
            self.global.userInfo.totalrewards = totalrewards
            self.global.userInfo.withdrawn = withdrawn
            self.global.userInfo.referralId = info["Item"]["accRefId"].stringValue
            self.global.userInfo.referralrewards = referralRewards
            self.global.userInfo.payments = payments
            self.global.userInfo.referredBy = referredBy
            self.global.userInfo.invitedFriends = invitedFriends
            self.global.userInfo.inviteDetailed = invite
                completion(true)
        }
    }
    
    
    func cashOut(uniqueID: String, cashOutValue: String, email: String, paymentType: String, password: String, completion: @escaping (Int) -> Void){
        let params = ["uniqueID": GlobalVariables.singleton.userInfo.uuid, "cashOutValue": cashOutValue, "email": email, "paymentType": paymentType, "password": password]
        AF.request(cashOut, parameters: params).responseJSON { (response) in
                        
            let info = JSON(response.data)
            
//            print("info", info)
//            
//            print("info headers \(response.response?.headers.dictionary)")
//
//            print("info item", info["error"].description)

            
            guard info["error"].intValue != 100 else{
                print("we are in null ")
                completion(-100) //using as false
                return
            }
            
            if (response.response?.headers.dictionary["Status"]) == "done" {
                let rewards = info["Item"]["rewards"].intValue
                 let totalrewards = info["Item"]["totalrewards"].intValue
                 let withdrawn = info["Item"]["withdrawnrewards"].intValue
                 let referralRewards = info["Item"]["referralrewards"].intValue
                 let payments = JSON(info["Item"]["payments"])
                 self.global.userInfo.rewards = rewards
                 self.global.userInfo.totalrewards = totalrewards
                 self.global.userInfo.withdrawn = withdrawn
                 self.global.userInfo.referralId = info["Item"]["accRefId"].stringValue
                 self.global.userInfo.referralrewards = referralRewards
                 self.global.userInfo.payments = payments

                GlobalVariables.singleton.userInfo.rewards = rewards
                self.updateInfoDelegate?.updateInfo()
                NotificationCenter.default.post(name: .didReceiveData, object: nil)
                    completion(200)
                return
            }else{
                completion(-200)
            }
        }
    }
    
    
    
    func deleteAccount(uniqueID: String,completion: @escaping (Bool) -> Void){
        let params = ["uniqueID": GlobalVariables.singleton.userInfo.uuid]
        AF.request(deleteAccount, parameters: params).responseJSON { (response) in
            let info = JSON(response.data)
            print("info", info)
            guard info["item"] != "null" else{
                completion(false)
                return
            }
                completion(true)
        }
    }
}
