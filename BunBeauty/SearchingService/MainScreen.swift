//
//  MainScreen.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 08/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class MainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let USERS:String = "users"
    private let CITY:String = "city"


    @IBOutlet weak var serviceMainScreenTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainScreen(category:"")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = serviceMainScreenTableView.dequeueReusableCell(withIdentifier: "mainScreenCell")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func createMainScreen(category:String) ->  Void {
        let userId = getUserId()
        
        let userCity = getUserCity(userId:userId)
        
        getService(city: userCity)
    }
    
    func getUserCity(userId:String) -> String {
        return ""
    }
    func getService(city:String) -> Void {
       
    }
    
    func goToGuestService(serviceId:String) {
        let  guestService = storyboard?.instantiateViewController(withIdentifier: "GuestService") as! GuestService
        guestService.serviceId = serviceId
        navigationController?.pushViewController(guestService, animated: true)
    }
    func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
}
