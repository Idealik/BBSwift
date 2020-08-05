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
    private let WORKING_DAYS:String = "working days"
    private let WORKING_TIME:String = "working time"
    
    private let DATE:String = "date"
    private let TIME:String = "time"
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
        ownerId = getOwnerId()
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
    
    }
    
    
    private func getOwnerId() -> String? {
        
        return nil
    }
    @IBAction func goToMyCalendar(_ sender: Any) {
       
    }
    
    func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
}
