//
//  TABLE_USERS.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 09/07/2019.
//Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift

class TABLE_USERS: Object {
    @objc dynamic var KEY_ID:String?
    @objc dynamic var KEY_PHONE_USERS:String?
    @objc dynamic var KEY_NAME_USERS:String?
    @objc dynamic var KEY_CITY_USERS:String?
    @objc dynamic var KEY_RATING_USERS:String?
    @objc dynamic var KEY_SUBSCRIPTIONS_COUNT_USERS:String?
    @objc dynamic var KEY_SUBSCRIBERS_COUNT_USERS:String?
}
