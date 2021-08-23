//
//  File.swift
//  Sika
//
//  Created by KWAME DARKO on 8/11/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import Foundation
import SwiftyJSON

struct userInfoStruct {
    var referralId = ""
    var referredBy = ""
    var rewards = 0
    var totalrewards = 0
    var withdrawn = 0
    var referralrewards = 0
    var invitedFriends = 0
    var uuid = ""
    var payments: JSON = []
    var inviteDetailed: JSON = []
    
}

class GlobalVariables {
    static let singleton = GlobalVariables()
    
    var userInfo = userInfoStruct()
    var awsExpiredTimestamp: Date?
}
