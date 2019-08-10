//
//  LoadingMainScreenElement.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 09/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RealmSwift
class LoadingMainScreenElement {
    
    private static let SERVICES:String = "services"
    private static let COST:String = "cost"
    private static let IS_PREMIUM:String = "is premium"
    private static let CATEGORY:String = "category"
    private static let CREATION_DATE:String = "creation date"
    private static let NAME:String = "name"
    private static let AVG_RATING:String = "avg rating"
    
    static func loadService(servicesSnapshot:DataSnapshot, userId:String){
        let realm = DBHelper().getDBhelper()

        for serviceSnapshot in servicesSnapshot.children{
            
            let serviceId = (serviceSnapshot as! DataSnapshot).key
            if WorkWithLocalStorageApi.hasSomeData(table: TABLE_SERVICES.self, keyId:serviceId){
                let serviceTable = realm.objects(TABLE_SERVICES.self).filter("KEY_ID = %@",serviceId)
                try! realm.write {
                    serviceTable.setValue(serviceId, forKey: "KEY_ID")
                    serviceTable.setValue((serviceSnapshot as AnyObject).childSnapshot(forPath: self.NAME).value as? String, forKey: "KEY_NAME_SERVICES")
                    serviceTable.setValue(userId, forKey: "KEY_USER_ID_SERVICES")
                    serviceTable.setValue((serviceSnapshot as AnyObject).childSnapshot(forPath: self.AVG_RATING).value as? String, forKey: "KEY_RATING_SERVICES")
                    serviceTable.setValue((serviceSnapshot as AnyObject).childSnapshot(forPath: self.CREATION_DATE).value as? String, forKey: "KEY_CREATION_DATE_SERVICES")
                    serviceTable.setValue((serviceSnapshot as AnyObject).childSnapshot(forPath: self.CATEGORY).value as? String, forKey: "KEY_CATEGORY_SERVICES")
                    serviceTable.setValue((serviceSnapshot as AnyObject).childSnapshot(forPath: self.IS_PREMIUM).value as? String, forKey: "KEY_IS_PREMIUM_SERVICES")
                    serviceTable.setValue((serviceSnapshot as AnyObject).childSnapshot(forPath: self.COST).value as? String, forKey: "KEY_MIN_COST_SERVICES")
                }
            }
            else{
                let serviceTable = TABLE_SERVICES()
                
                serviceTable.KEY_ID = serviceId
                serviceTable.KEY_NAME_SERVICES = (serviceSnapshot as AnyObject).childSnapshot(forPath: self.NAME).value as? String
                serviceTable.KEY_USER_ID_SERVICES = userId
                serviceTable.KEY_RATING_SERVICES = (serviceSnapshot as AnyObject).childSnapshot(forPath: self.AVG_RATING).value as? String
                serviceTable.KEY_CREATION_DATE_SERVICES = (serviceSnapshot as AnyObject).childSnapshot(forPath: self.CREATION_DATE).value as? String
                serviceTable.KEY_CATEGORY_SERVICES = (serviceSnapshot as AnyObject).childSnapshot(forPath: self.CATEGORY).value as? String
                serviceTable.KEY_IS_PREMIUM_SERVICES = (serviceSnapshot as AnyObject).childSnapshot(forPath: self.IS_PREMIUM).value as? String
                serviceTable.KEY_MIN_COST_SERVICES = (serviceSnapshot as AnyObject).childSnapshot(forPath: self.COST).value as? String
                try! realm.write {
                    realm.add(serviceTable)
                }
            }
        }
    }
}
