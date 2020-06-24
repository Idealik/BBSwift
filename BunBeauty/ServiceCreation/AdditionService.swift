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
        else{
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-125, y: self.view.frame.size.height-100, width: 250, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.text = "Не все поля заполнены"
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
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

        goToMyCalendar(serviceId: service.getId())
    }
    
    private func isFullInputs() -> Bool {
        if(nameText.text == "" || descriptionInput.text == "" || costText.text == "" || addressInput.text == "") {
            return false
        }
        return true
    }
    
    private func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    func goToMyCalendar(serviceId:String) {
      
        
    }
}
