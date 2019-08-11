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

    private var serviceList = [ServiceEntity]()
    private var userList = [UserEntity]()
    @IBOutlet weak var serviceMainScreenTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainScreen(category:"")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return serviceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = serviceMainScreenTableView.dequeueReusableCell(withIdentifier: "mainScreenCell")!
        cell.textLabel?.text = serviceList[indexPath.row].getName()
        return cell
    }

    func createMainScreen(category:String) ->  Void {
        let userId = getUserId()
        
        let userCity = getUserCity(userId:userId)
        
        getService(city: userCity)
    }
    
    func getUserCity(userId:String) -> String {
        let realm = DBHelper().getDBhelper()
        let userCursor = realm.objects(TABLE_USERS.self).filter("KEY_ID = %@",userId)
        for user in userCursor{
            return user.KEY_CITY_USERS!
        }
        return ""
    }
    func getService(city:String) -> Void {
        let userQuery = Database.database().reference()
            .child(USERS)
            .queryOrdered(byChild: CITY)
            .queryEqual(toValue : city)
        
        userQuery.observeSingleEvent(of: .value) { (usersSnapshot) in
            //get services
            var commonList = [[Any]]()
            commonList =  Search.getServicesOfUsers(usersSnapshot: usersSnapshot, serviceName: "", userName: "", city: "", category: "")
            print("Common list \(commonList)")
            for serviceData in commonList{
                self.serviceList.append(serviceData[1] as! ServiceEntity)
                self.userList.append(serviceData[2] as! UserEntity)
            }
            self.serviceMainScreenTableView.reloadData()
        }
    }
    func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
}
