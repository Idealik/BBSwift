//
//  TABLE_WORKING_DAYS.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 03/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
class TABLE_WORKING_DAYS: Object {
    @objc dynamic var KEY_ID:String?
    @objc dynamic var KEY_DATE_WORKING_DAYS:String?
    @objc dynamic var KEY_SERVICE_ID_WORKING_DAYS:String?
}
