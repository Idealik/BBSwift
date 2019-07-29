//
//  AdditionService.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
class AdditionService: UIViewController {
    
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

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var costText: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addServiceBtn(_ sender: Any) {
        if(isFullInputs()){
            let service = ServiceEntity()
            service.setName(_name: nameText.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            service.setCost(_cost: costText.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            service.setAddress(_address: addressInput.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            service.setDescription(_description: descriptionInput.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            service.setUserId(_userId: getUserId())
            service.setCategory(_category: "-")
            service.setCountOfRates(_countOfRates: 0)
            service.setAverageRating(_rating: 0)
            service.setIsPremium(_isPremium: false)
            uploadService(service: service)
        }
    }
    
    func uploadService(service:ServiceEntity) -> Void {
        var serviceRef = Database.database().reference()
            .child(USERS)
        .child(getUserId())
        .child(SERVICES)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(service.getName(), forKey: NAME)
        items.updateValue(0, forKey: AVG_RATING)
        items.updateValue(service.getCost(), forKey: COST)
        items.updateValue(service.getDescription(), forKey: DESCRIPTION)
        items.updateValue("1970-01-01 00:00", forKey: IS_PREMIUM)
        items.updateValue("", forKey: CATEGORY)
        items.updateValue(service.getAddress(), forKey: ADDRESS)
        items.updateValue(0, forKey: COUNT_OF_RATES)
        items.updateValue(WorkWithTimeApi.getDateInFormatYMDHS(date: Date()), forKey: CREATION_DATE)
        let serviceId = serviceRef.childByAutoId().key!
        serviceRef = serviceRef.child(serviceId)
        serviceRef.updateChildValues(items)
        
        service.setId(_id: serviceId)
        addServiceInLocalStorage(service: service)
    }
    
    func addServiceInLocalStorage(service:ServiceEntity) -> Void {
        let realm = DBHelper().getDBhelper()
        let serviceTable = TABLE_SERVICES()
        serviceTable.KEY_ID = service.getId()
        serviceTable.KEY_NAME_SERVICES = service.getName()
        serviceTable.KEY_RATING_SERVICES = "0"
        serviceTable.KEY_MIN_COST_SERVICES = service.getCost()
        serviceTable.KEY_DESCRIPTION_SERVICES = service.getDescription()
        serviceTable.KEY_USER_ID_SERVICES = service.getUserId()
        serviceTable.KEY_CATEGORY_SERVICES = service.getCategory()
        serviceTable.KEY_ADDRESS_SERVICES = service.getAddress()
        
        try! realm.write {
            realm.add(serviceTable)
        }
    }
    
    private func isFullInputs() -> Bool {
        if(nameText.text == nil && descriptionInput.text == nil && costText.text == nil && addressInput.text == nil) {
            return false
        }
        return true
    }
    
    private func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
}
