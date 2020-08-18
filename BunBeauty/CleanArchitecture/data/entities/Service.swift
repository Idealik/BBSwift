//
//  Service.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 03.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
struct Service {
    var id: String = ""
    var userId:String = ""
    var name:String = ""
    var duration:Float = 0
    var address:String = ""
    var description:String = ""
    var category:String = ""
    var rating:Float = 0
    var countOfRates:Int = 0
    var cost:Int = 0
    var creationDate:Int = 0
    var premiumDate:Int = 0
    //CONSTS
    static let USERS:String = "users"
    static let NAME:String = "name"
    static let SERVICES:String = "services"
    static let AVG_RATING:String = "avg rating"
    static let COST:String = "cost"
    static let DESCRIPTION:String = "description"
    static let IS_PREMIUM:String = "is premium"
    static let CATEGORY:String = "category"
    static let ADDRESS:String = "address"
    static let COUNT_OF_RATES:String = "count of rates"
    static let CREATION_DATE:String = "creation date"
}
