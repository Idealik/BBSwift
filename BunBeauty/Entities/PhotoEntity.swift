//
//  PhotoEntity.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation

class PhotoEntity {
    private var photoId:String!
    private var photoLink:String!
    private var photoOnwerId:String!
    
    func setPhotoId(id:String) {
        photoId = id
    }
    func getPhotoId() -> String {
        return photoId
    }
    
    func setPhotoLink(_photoLink:String) {
        photoLink = _photoLink
    }
    func getPhotoLink() -> String {
        return photoLink
    }
    
    func setPhotoOwnerId(_ownerId:String) {
        photoOnwerId = _ownerId
    }
    func getPhotoOnwerId() -> String {
        return photoOnwerId
    }
}
