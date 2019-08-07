//
//  GuestService.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 05/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class GuestService: UIViewController {
    
    private let WORKER = "worker"
    private let USER = "user"
    private let USERS:String = "users"
    private let NAME:String = "name"
    private let SERVICES:String = "services"
    private let AVG_RATING:String = "avg rating"
    private let COST:String = "cost"
    private let DESCRIPTION:String = "description"
    private let IS_PREMIUM:String = "is premium"
    private let CATEGORY:String = "category"
    private let ADDRESS:String = "address"
    private let COUNT_OF_RATES:String = "count of rates"
    private let CREATION_DATE:String = "creation date"
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var costText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    var serviceId:String!
    
    @IBOutlet weak var guestServiceBtn: UIButton!
    private var isMyService:Bool!
    private var status:String!
    private var ownerId:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        ownerId = getUserId()
        isMyService = ownerId == getUserId()
        
        if isMyService{
            status = WORKER
            guestServiceBtn.setTitle("Редактировать расписание", for: .normal)
        }
        else{
            status = USER
            guestServiceBtn.setTitle("Расписание", for: .normal)
        }
        
        loadServiceData()
    }
    
    private func loadServiceData(){
        let ref = Database.database().reference()
            .child(USERS)
            .child(ownerId)
        ref.observeSingleEvent(of: .value) { (userSnapshot) in
            //load photo
            
            let service = ServiceEntity()
            service.setUserId(_userId: userSnapshot.key)

            //load service
            let serviceSnapshot = userSnapshot.childSnapshot(forPath: self.SERVICES)
                .childSnapshot(forPath: self.serviceId)
            
            service.setId(_id: serviceSnapshot.key)
            service.setCost(_cost: serviceSnapshot.childSnapshot(forPath: self.COST).value as! String)
            service.setAddress(_address: serviceSnapshot.childSnapshot(forPath: self.ADDRESS).value as! String)
            service.setDescription(_description: serviceSnapshot.childSnapshot(forPath: self.DESCRIPTION).value as! String)
            service.setName(_name: serviceSnapshot.childSnapshot(forPath: self.NAME).value as! String)
            service.setAverageRating(_rating: serviceSnapshot.childSnapshot(forPath: self.AVG_RATING).value as! Float)
            service.setCountOfRates(_countOfRates: serviceSnapshot.childSnapshot(forPath: self.COUNT_OF_RATES).value as! Int)
            //service.setIsPremium(_isPremium: serviceSnapshot.childSnapshot(forPath: self.IS_PREMIUM).value as! Bool)
            self.setGuestService(service: service)
            LoadingGuestServiceData.addServiceInLocalStorage(service: service)

            //load wokring days
        }
    }
    
    private func setGuestService(service:ServiceEntity){
        nameText.text = service.getName()
        costText.text = service.getCost()
        descriptionText.text = service.getDescription()
        //premium
        //photo feed
        //rates
    }
    
    private func getOwnerId() -> String{
        let realm = DBHelper().getDBhelper()
        let ownerCursor = realm.objects(TABLE_SERVICES.self).filter("KEY_ID == %@", serviceId!)
        
        for ownerId in ownerCursor{
            return ownerId.KEY_ID!
        }
        return ""
    }
    @IBAction func goToMyCalendar(_ sender: Any) {
        
    }
    
    func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
}
