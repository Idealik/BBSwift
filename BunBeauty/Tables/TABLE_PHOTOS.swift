//
//  TABLE_PHOTOS.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 10/07/2019.
//Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift

class TABLE_PHOTOS: Object {
    
    @objc dynamic var KEY_ID:String?
    @objc dynamic var KEY_PHOTO_LINK_PHOTOS:String?
    @objc dynamic var KEY_OWNER_ID_PHOTOS:String?

}
