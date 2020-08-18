//
//  Photo.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
struct Photo {
    var id:String = ""
    var link:String = ""
    var userId:String = ""
    var serviceId:String = ""
    
    static let PHOTOS = "photos"
    static let PHOTO = "photo"
    static let LINK = "link"
    static let PHOTO_CALLBACK = "photo callback"
}
