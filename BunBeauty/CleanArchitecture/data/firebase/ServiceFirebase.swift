//
//  ServiceFirebase.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 01.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ServiceFirebase {
    
    func insert(service:Service){
        var serviceRef = Database.database().reference()
            .child(User.USERS)
            .child(service.userId)
            .child(Service.SERVICES)
            .child(service.id)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(service.name, forKey: Service.NAME)
        items.updateValue(service.address, forKey: Service.ADDRESS)
        items.updateValue(service.description, forKey: Service.DESCRIPTION)
        items.updateValue(service.cost, forKey:Service.COST)
        items.updateValue(service.category, forKey:Service.CATEGORY)
        items.updateValue(WorkWithTimeApi.getDateInFormatYMDHS(date: Date()), forKey: Service.CREATION_DATE)
        items.updateValue("1970-01-01 00:00", forKey: Service.IS_PREMIUM)
        items.updateValue(service.rating, forKey: Service.AVG_RATING)
        items.updateValue(0, forKey: Service.COUNT_OF_RATES)
        let serviceId = serviceRef.childByAutoId().key!
        serviceRef = serviceRef.child(serviceId)
        serviceRef.updateChildValues(items)
    }
    
    func getIdForNew(service:Service) -> String {
        return  Database.database().reference().child(User.USER).child(service.userId).child(Service.SERVICES).childByAutoId().key!
    }
}
