//
//  TABLE_REVIEWS.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 16/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
class TABLE_REVIEWS: Object {
    @objc dynamic var KEY_ID:String?
    @objc dynamic var KEY_REVIEW_REVIEWS:String?
    @objc dynamic var KEY_RATING_REVIEWS:String?
    @objc dynamic var KEY_TYPE_REVIEWS:String?
    @objc dynamic var KEY_TIME_REVIEWS:String?
    @objc dynamic var KEY_ORDER_ID_REVIEWS:String?
}
