//
//  LoadingProfileData.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 10/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RealmSwift

class LoadingProfileData {

    private static let PHONE:String = "phone"
    private static let USERS:String = "users"
    private static let NAME:String = "name"
    private static let CITY:String = "city"
    private static let AVG_RATING:String = "avg rating"
    private static let COUNT_OF_RATES:String = "count of rates"
    private static let PHOTO_LINK:String = "photo link"
    
    //service
    private static let SERVICES:String = "services"
    
    static func loadUserInfo(userSnapshot:DataSnapshot, localDatabse:Realm) {
        let userId = userSnapshot.key
        //load photo
        //load subscriptions
        
        //load user
        let name = userSnapshot.childSnapshot(forPath: self.NAME).value as! String
        let phone = userSnapshot.childSnapshot(forPath: self.PHONE).value as! String
        let city = userSnapshot.childSnapshot(forPath: self.CITY).value as! String
        let countOfRates = userSnapshot.childSnapshot(forPath: self.COUNT_OF_RATES).value as! Int
        let rating = userSnapshot.childSnapshot(forPath: self.AVG_RATING).value as! Float

        let user = UserEntity()
        user.setPhone(_phone:phone)
        user.setName(_name: name)
        user.setCity(_city: city)
        user.setCountOfRates(data: countOfRates)
        user.setRating(data: rating)
        user.setId(data: userId)
        addUserInLocalSrorageMy(_user: user)
        
        //load photo
        let photo = PhotoEntity()
        let photoLink = userSnapshot.childSnapshot(forPath: self.PHOTO_LINK).value as! String

        photo.setPhotoId(id: userId)
        photo.setPhotoOwnerId(_ownerId: userId)
        photo.setPhotoLink(_photoLink: photoLink)
        addPhotoInLocalStorage(photo: photo)
    }
    static func loadUserServices(servicesSnapshot:DataSnapshot, userId:String) -> Void {
        for serviceSnapshot in servicesSnapshot.children{
            let service = ServiceEntity()
            service.setId(_id: (serviceSnapshot as AnyObject).key)
            service.setName(_name: (serviceSnapshot as AnyObject).childSnapshot(forPath: self.NAME).value as! String)
            service.setUserId(_userId: userId)
            service.setAverageRating(_rating: (serviceSnapshot as AnyObject).childSnapshot(forPath: self.AVG_RATING).value as! Float)
            addServiceInLocalStroage(service: service)
        }
    }
    static private func addServiceInLocalStroage(service:ServiceEntity){
        let realm = DBHelper().getDBhelper()
        let serviceTable = TABLE_SERVICES()
        
        serviceTable.KEY_ID = service.getId()
        serviceTable.KEY_NAME_SERVICES = service.getName()
        serviceTable.KEY_RATING_SERVICES = String(service.getAverageRating())
        serviceTable.KEY_USER_ID_SERVICES = service.getUserId()
        
        try! realm.write {
            realm.add(serviceTable)
        }
    }
    
    static private func addUserInLocalSrorageMy(_user:UserEntity){
        let realm = DBHelper().getDBhelper()
        let userTable = TABLE_USERS()
        userTable.KEY_ID = _user.getId()
        userTable.KEY_CITY_USERS = _user.getCity()
        userTable.KEY_NAME_USERS = _user.getName()
        userTable.KEY_PHONE_USERS = _user.getPhone()
        userTable.KEY_RATING_USERS = "0"
        userTable.KEY_SUBSCRIBERS_COUNT_USERS = "0"
        userTable.KEY_SUBSCRIPTIONS_COUNT_USERS = "0"
        try! realm.write {
            realm.add(userTable)
        }
    }
    
    static private func addPhotoInLocalStorage(photo:PhotoEntity) -> Void {
        let realm = DBHelper().getDBhelper()
        let photoTable = TABLE_PHOTOS()
        photoTable.KEY_ID = photo.getPhotoId()
        photoTable.KEY_OWNER_ID_PHOTOS = photo.getPhotoOnwerId()
        photoTable.KEY_PHOTO_LINK_PHOTOS = photo.getPhotoLink()
        try! realm.write {
            realm.add(photoTable)
        }
    }
    
}
