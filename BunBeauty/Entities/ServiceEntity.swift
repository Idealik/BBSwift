//
//  ServiceEntity.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 28/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
class ServiceEntity {
    var id:String!
    var name:String!
    var averageRating:Float!
    var description:String!
    var cost:String!
    var userId:String!
    var category:String!
    var isPremium:Bool!
    var creationDate:String!
    var address:String!
    var countOfRates:Int!

    func setId(_id:String) {
        id = _id
    }
    func getId() -> String {
        return id
    }
   
    func setName(_name:String) {
        name = _name
    }
    func getName() -> String {
        return name
    }
    
    func setAverageRating(_rating:Float) {
        averageRating = _rating
    }
    func getAverageRating() -> Float{
        return averageRating
    }
    
    func setDescription(_description:String) {
        description = _description
    }
    func getDescription() -> String {
        return description
    }
    
    func setCost(_cost:String) {
        cost = _cost
    }
    func getCost() -> String {
        return cost
    }
    
    func setUserId(_userId:String) {
        userId = _userId
    }
    func getUserId() -> String {
        return userId
    }
    
    func setCategory(_category:String) {
        category = _category
    }
    func getCategory() -> String {
        return category
    }
    
    func setIsPremium(_isPremium:Bool) {
        isPremium = _isPremium
    }
    func getIsPremium() -> Bool {
        return isPremium
    }
    
    func setCreationDate(_creationDate:String) {
        creationDate = _creationDate
    }
    func getCreationDate() -> String {
        return creationDate
    }
    
    func setAddress(_address:String) {
        address = _address
    }
    func getAddress() -> String {
        return address
    }
    
    func setCountOfRates(_countOfRates:Int) {
        countOfRates = _countOfRates
    }
    func getCountOfRates() -> Int {
        return countOfRates
    }
    
}
