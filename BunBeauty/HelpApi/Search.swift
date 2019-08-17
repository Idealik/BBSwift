//
//  Search.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 09/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RealmSwift
class Search {
    
    private static let CITY:String = "city"
    private static let NOT_CHOSEN:String = "не выбран"
    private static let SERVICES:String = "services"
    
    private static let CREATION_DATE:String = "creation date"
    private static let COST:String = "cost"
    private static let RATING:String = "rating"
    private static var maxCost:Int!
    
    private static var serviceList = [[Any]]()
    
    static func getServicesOfUsers(usersSnapshot:DataSnapshot, serviceName:String, userName:String, city:String, category:String) -> [[Any]] {
        serviceList.removeAll()
        for userSnapshot in usersSnapshot.children{
            let userCity = (userSnapshot as AnyObject).childSnapshot(forPath: CITY).value as! String
            if city == "" || city == userCity || city == NOT_CHOSEN {
                // download for ms
                LoadingUserElement.loadUserNameAndPhotoWithCity(userSnapshot: userSnapshot as! DataSnapshot)
                LoadingMainScreenElement.loadService(servicesSnapshot: (userSnapshot as! DataSnapshot).childSnapshot(forPath: SERVICES) , userId: (userSnapshot as! DataSnapshot).key)
            }
        }
        updateServiceList(serviceName: serviceName , userName: userName , city: city, category: category)
        
        return serviceList
    }
    
    static private func updateServiceList(serviceName:String, userName:String, city:String, category:String) -> Void {
        maxCost = getMaxCost()
        let realm = DBHelper().getDBhelper()
        let usersCursor = realm.objects(TABLE_USERS.self)
        
        for userCursor in usersCursor {
            let user = UserEntity()
            let userId = userCursor.value(forKey: "KEY_ID") as! String
            user.setId(data: userId)
            user.setName(_name: userCursor.value(forKey: "KEY_NAME_USERS") as! String)
            user.setCity(_city: userCursor.value(forKey: "KEY_CITY_USERS") as! String)
            let servicesCursor = realm.objects(TABLE_SERVICES.self).filter("KEY_USER_ID_SERVICES = %@", userId)
            

            for serviceCursor in servicesCursor{
                let service = ServiceEntity()
                service.setId(_id: serviceCursor.value(forKey: "KEY_ID") as! String)
                service.setName(_name: serviceCursor.value(forKey: "KEY_NAME_SERVICES") as! String)
                service.setCost(_cost: serviceCursor.value(forKey: "KEY_MIN_COST_SERVICES") as! String)
                //checkPremium
                //service.setIsPremium(_isPremium: <#T##Bool#>)
                service.setCreationDate(_creationDate: serviceCursor.value(forKey: "KEY_CREATION_DATE_SERVICES") as! String)
                
                service.setAverageRating(_rating: (serviceCursor.value(forKey: "KEY_RATING_SERVICES") as! NSString).floatValue)
                
                addToServiceList(user: user, service: service)
            }
        }
    }
    
    static private func addToServiceList(user:UserEntity, service:ServiceEntity){
        var coefficients: [String:Float] = [:]
        coefficients.updateValue(0.25, forKey: CREATION_DATE)
        coefficients.updateValue(0.07, forKey: COST)
        coefficients.updateValue(0.68, forKey: RATING)
        
        //if isPremium
        let creationDatePoints = figureCreationDatePoints(creationDate: service.getCreationDate(), coefficient: coefficients[CREATION_DATE]!)
        let costPoints = figureCostPoints(cost: Int(service.getCost())!, coefficient: coefficients[COST]!)
        let ratingPoints = figureRatingPoints(rating: service.getAverageRating(), coefficient: coefficients[RATING]!)
        let penaltyPoints = figurePenaltyPoints(serviceId: service.getId(), userId: user.getId())
        let points = creationDatePoints+costPoints+ratingPoints - penaltyPoints
        var serviceData:[Any] = []
        serviceData.append(points)
        serviceData.append(service)
        serviceData.append(user)
        print(serviceData)
        sortAddition(serviceData: serviceData)
    }
    
    static private func figureCreationDatePoints(creationDate:String, coefficient:Float) -> Float{
        var creationDatePoints:Float = 0
        let dateBonus = (WorkWithTimeApi.getMillisecondsStringDateYMDHMS(date: creationDate) - WorkWithTimeApi.getSysadateInt()) / (3600000*24)+7
        if dateBonus < 0{
            creationDatePoints = 0
        }else{
            creationDatePoints = Float(dateBonus * Double(coefficient/7))
        }
        return Float(creationDatePoints)
    }
    
    static private func figureCostPoints(cost:Int, coefficient:Float) -> Float{
        return Float((1-cost*1/maxCost))*coefficient
    }
    static private func figureRatingPoints(rating:Float, coefficient:Float) -> Float{
        return rating*coefficient/5
    }
    static private func figurePenaltyPoints(serviceId:String, userId:String) -> Float{
        let penaltyPoints = 0
        
        return Float(penaltyPoints)
    }
    
    static private func getMaxCost() -> Int {
        return 1000
    }
    
    static private func sortAddition(serviceData:[Any]) -> Void{
        var i = 0
        while i<serviceList.count {
            if (serviceList[i][0] as! Float) < (serviceData[0] as! Float){
                serviceList.insert(serviceData, at: i)
                return
            }
            i += 1
        }
        serviceList.append(serviceData)
    }
    
}
