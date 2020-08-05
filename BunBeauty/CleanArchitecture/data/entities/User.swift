//
//  User.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 03.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseAuth
struct User {
    var id: String = ""
    var name: String = ""
    var surname: String = ""
    var city: String = ""
    var phone: String = ""
    var rating: Float = 0
    var countOfRates: Int = 0
    var photoLink: String = DEFAULT_PHOTO_LINK
    var subscribersCount: Int = 0
    var subscriptionsCount: Int = 0
    var registrationDate = 0
    
    static let USERS = "users"
    static let USER = "user"
    static let USER_ID = "user id"
    static let PHONE = "phone"
    static let NAME = "name"
    static let SURNAME = "surname"
    static let CITY = "city"
    static let PHOTO_LINK = "photo link"
    static let AVG_RATING = "avg rating"
    static let COUNT_OF_RATES = "count of rates"
    static let COUNT_OF_SUBSCRIBERS = "count of subscribers"
    static let COUNT_OF_SUBSCRIPTIONS = "count of subscriptions"
    static let DEFAULT_PHOTO_LINK = "https://firebasestorage.googleapis.com/v0/b/bun-beauty.appspot.com/o/avatar%2FdefaultAva.jpg?alt=media&token=f15dbe15-0541-46cc-8272-2578627ed311"
    static let REGISTRATION_DATA = "registration data"
    
    static func getMyId() ->String {
        return Auth.auth().currentUser!.uid
    }
}
