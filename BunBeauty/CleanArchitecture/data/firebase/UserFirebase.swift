//
//  UserFirebase.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 24.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
class UserFirebase {
    
    func insert(user:User) {
        
        let userRef = Database.database().reference().child(User.USERS).child(user.id)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(user.name, forKey: User.NAME)
        items.updateValue(user.surname, forKey: User.SURNAME)
        items.updateValue(user.city, forKey: User.CITY)
        items.updateValue(user.phone, forKey: User.PHONE)
        items.updateValue(user.rating, forKey: User.AVG_RATING)
        items.updateValue(user.photoLink, forKey: User.PHOTO_LINK)
        items.updateValue(user.subscribersCount, forKey: User.COUNT_OF_SUBSCRIBERS)
        items.updateValue(user.subscriptionsCount, forKey: User.COUNT_OF_SUBSCRIPTIONS)
        items.updateValue(user.countOfRates, forKey: User.COUNT_OF_RATES)
        items.updateValue(ServerValue.timestamp, forKey: User.COUNT_OF_RATES)
        userRef.updateChildValues(items)
    }
    
    func update(user:User){
        let userRef = Database.database().reference().child(User.USERS).child(user.id)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(user.name, forKey: User.NAME)
        items.updateValue(user.surname, forKey: User.SURNAME)
        items.updateValue(user.city, forKey: User.CITY)
        items.updateValue(user.phone, forKey: User.PHONE)
        items.updateValue(user.rating, forKey: User.AVG_RATING)
        items.updateValue(user.photoLink, forKey: User.PHOTO_LINK)
        items.updateValue(user.subscribersCount, forKey: User.COUNT_OF_SUBSCRIBERS)
        items.updateValue(user.subscriptionsCount, forKey: User.COUNT_OF_SUBSCRIPTIONS)
        items.updateValue(user.countOfRates, forKey: User.COUNT_OF_RATES)
        items.updateValue(ServerValue.timestamp, forKey: User.COUNT_OF_RATES)
        userRef.updateChildValues(items)
    }
    
    func getByPhoneNumber(userPhone:String, getUserCallback:GetUserCallback) {
        let ref = Database.database().reference()
            .child(User.USERS)
            .queryOrdered(byChild: User.PHONE)
            .queryEqual(toValue : userPhone)
        
        ref.observeSingleEvent(of: .value) { (usersSnapshot) in
        
            if(usersSnapshot.childrenCount != 0 ){
                getUserCallback.returnElement(element: self.getUserFromSnapshot(userSnapshot: usersSnapshot.children.nextObject() as! DataSnapshot))
            }
        
        }
    }
    
    func getUserFromSnapshot(userSnapshot: DataSnapshot)-> User {
        var user = User()
        user.id = userSnapshot.key
        
        user.name = userSnapshot.childSnapshot(forPath: User.NAME).value as! String
        user.surname = userSnapshot.childSnapshot(forPath: User.NAME).value as! String
        user.city = userSnapshot.childSnapshot(forPath: User.NAME).value as! String
        user.phone = userSnapshot.childSnapshot(forPath: User.NAME).value as! String
        user.rating = userSnapshot.childSnapshot(forPath: User.NAME).value as! Float
        user.photoLink = userSnapshot.childSnapshot(forPath: User.NAME).value as! String
        user.subscribersCount = userSnapshot.childSnapshot(forPath: User.NAME).value as! Int
        user.subscriptionsCount = userSnapshot.childSnapshot(forPath: User.NAME).value as! Int
        user.countOfRates = userSnapshot.childSnapshot(forPath: User.NAME).value as! Int
        
        return user
    }
    
    func getNewId(user:User) -> String? {
        return Auth.auth().currentUser?.uid
    }
}
