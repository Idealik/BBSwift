//
//  UserEntity.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 08/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit

class UserEntity{

    private var phone:String!
    private var name:String!
    private var city:String!
    private var id:String!
    private var rating:Float!
    private var coutOfRates:Int!

    func setPhone(_phone:String) {
        phone = _phone
    }
    func getPhone() -> String {
        return phone
    }
    
    func setName(_name:String) {
        name = _name
    }
    func getName() -> String {
        return name
    }
    
    func setCity(_city:String) {
        city = _city
    }
    func getCity() -> String {
        return city
    }
    
    func setId(data:String) {
        id = data
    }
    func getId() -> String {
        return id
    }
    
    func setRating(data:Float) {
        rating = data
    }
    func getRating() -> Float {
        return rating
    }
    
    func setCountOfRates(data:Int) {
        coutOfRates = data
    }
    func getCountOfRates() -> Int {
        return coutOfRates
    }
    
}
