//
//  LoadingGuestServiceData.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 06/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase
class LoadingGuestServiceData: Object {
    static func addServiceInLocalStorage(service:ServiceEntity) {
        let realm = DBHelper().getDBhelper()
        //read element from databse
        let serviceTable = realm.objects(TABLE_SERVICES.self).filter("KEY_ID = '" + service.getId() + "'")
        
        try! realm.write {
            serviceTable.setValue(service.getId(), forKey: "KEY_ID")
            serviceTable.setValue(service.getDescription(), forKey: "KEY_DESCRIPTION_SERVICES")
            serviceTable.setValue(service.getCost(), forKey: "KEY_MIN_COST_SERVICES")
            serviceTable.setValue(String(service.getCountOfRates()), forKey: "KEY_COUNT_OF_RATES_SERVICES")
            serviceTable.setValue(String(service.getAverageRating()), forKey: "KEY_RATING_SERVICES")
            serviceTable.setValue(service.getAddress(), forKey: "KEY_ADDRESS_SERVICES")
            serviceTable.setValue(service.getUserId(), forKey: "KEY_USER_ID_SERVICES")

            //serviceTable.KEY_IS_PREMIUM_SERVICES = service.getIsPremium()
            
        }
    }
}
