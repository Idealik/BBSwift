//
//  LoadingUserElement.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 09/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RealmSwift
class LoadingUserElement {
    private static let NAME:String = "name"
    private static let CITY:String = "city"

    static func loadUserNameAndPhotoWithCity(userSnapshot:DataSnapshot){
        //load photo
        
        //load info
        let user = UserEntity()
        user.setId(data: userSnapshot.key)
        user.setName(_name: userSnapshot.childSnapshot(forPath: self.NAME).value as! String)
        user.setCity(_city: userSnapshot.childSnapshot(forPath: self.CITY).value as! String)
    }
    
    private func addUserInfoInLocalStorage(user:UserEntity) -> Void {
        let realm = DBHelper().getDBhelper()
        let userTable = TABLE_USERS()
        userTable.KEY_ID = user.getId()
        userTable.KEY_CITY_USERS = user.getCity()
        userTable.KEY_NAME_USERS = user.getName()
        try! realm.write {
            realm.add(userTable)
        }
    }
}
