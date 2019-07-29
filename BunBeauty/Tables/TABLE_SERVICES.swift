//
//  TABLE_SERVICES.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 28/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
class TABLE_SERVICES: Object {
    @objc dynamic var KEY_ID:String?
    @objc dynamic var KEY_USER_ID_SERVICES:String?
    @objc dynamic var KEY_NAME_SERVICES:String?
    @objc dynamic var KEY_RATING_SERVICES:String?
    @objc dynamic var KEY_DESCRIPTION_SERVICES:String?
    @objc dynamic var KEY_MIN_COST_SERVICES:String?
    @objc dynamic var KEY_IS_PREMIUM_SERVICES:String?
    @objc dynamic var KEY_CATEGORY_SERVICES:String?
    @objc dynamic var KEY_ADDRESS_SERVICES:String?
    @objc dynamic var KEY_COUNT_OF_RATES_SERVICES:String?
    @objc dynamic var KEY_CREATION_DATE_SERVICES:String?
}
