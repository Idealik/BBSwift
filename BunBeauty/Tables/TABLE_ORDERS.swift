//
//  TABLE_ORDERS.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 12/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
class TABLE_ORDERS:Object {
    @objc dynamic var KEY_ID:String?
    @objc dynamic var KEY_USER_ID:String?
    @objc dynamic var KEY_IS_CANCELED_ORDERS:String?
    @objc dynamic var KEY_MESSAGE_TIME_ORDERS:String?
    @objc dynamic var KEY_WORKING_TIME_ID_ORDERS:String?
}
