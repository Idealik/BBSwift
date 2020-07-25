//
//  UserRepository.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 03.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class UserRepository {
    var userFirebase:UserFirebase?
    
    init(userFirebase:UserFirebase) {
        self.userFirebase = userFirebase
    }
    
    func insert(_user:User, insertUserCallback:InsertUserCallback) {
        //asynk
        var user = _user
        user.id = userFirebase?.getNewId(user: user) ?? "1"
        userFirebase?.insert(user: user)
        insertUserCallback.returnCreatedCallback(obj: user)
    }
    
    func update(user:User, updateUserCallback:UpdateUserCallback) {
        userFirebase?.update(user: user)
        updateUserCallback.returnUpdatedCallback(obj: user)
    }
    
    func getByPhoneNumber(userPhone:String, getUserCallback:GetUserCallback) {
        userFirebase?.getByPhoneNumber(userPhone: userPhone, getUserCallback: getUserCallback)
    }
    
    public static func getInstance() -> UserRepository {
        return UserRepository(userFirebase: UserFirebase())
    }
    
}
