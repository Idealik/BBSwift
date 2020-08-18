//
//  Subscription.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
struct Subscription {
    var id: String = ""
    var userId:String = ""
    var date:Int = 0
    var subscriptionId:String = ""
    //CONSTS
    static let SUBSCRIPTIONS:String = "subscriptions"
    static let SUBSCRIPTION_ID:String = "subscription id"
    static let DATE:String = "date"
}
