//
//  Profile.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 09/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import FirebaseAuth
class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var cityTex: UILabel!
    @IBOutlet weak var phoneText: UILabel!
    @IBOutlet weak var serviceTableView: UITableView!
    var ownerId:String!
    var serviceList = [ServiceEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId = getUserId()
        
        if(ownerId == nil){
            ownerId = userId
            //initFCM
        }
        if(userId == ownerId){
            // визуал моего профиля
            
            // set data
        }
        else{
            //визуал др профиля
        }
        updateProfileData(ownerId: ownerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        serviceList.removeAll()
        updateServiceList(ownerId: ownerId)
        self.serviceTableView.reloadData()
    }
    
    private func updateProfileData(ownerId:String) -> Void {
        let user = UserEntity()
        setProfileData(_user: user)
    }
    
    private func  setProfileData(_user:UserEntity) -> Void {
        nameText.text = _user.getName()
        cityTex.text = _user.getCity()
        phoneText.text = _user.getPhone()
        //get rating
        //set avatar
        //updateServiceList()!
    }
    func updateServiceList(ownerId:String) -> Void {
    
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return serviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = serviceTableView.dequeueReusableCell(withIdentifier: "serviceIdCell")!
        cell.textLabel?.text = serviceList[indexPath.row].getName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToGuestService(serviceId: serviceList[indexPath.row].getId())
    }
    func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    @IBAction func goToMainScreen(_ sender: Any) {
        let  mainScreen = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
        navigationController?.pushViewController(mainScreen, animated: true)
    }
    
    @IBAction func goToAdditionService(_ sender: Any) {
        let  additionServiceVC = storyboard?.instantiateViewController(withIdentifier: "AdditionService") as! AdditionService
        navigationController?.pushViewController(additionServiceVC, animated: true)
    }
    
    func goToGuestService(serviceId:String) {
        let  guestService = storyboard?.instantiateViewController(withIdentifier: "GuestService") as! GuestService
        guestService.serviceId = serviceId
        navigationController?.pushViewController(guestService, animated: true)
    }
    
    
}
