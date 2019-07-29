//
//  Profile.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 09/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import FirebaseAuth
class Profile: UIViewController {

    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var cityTex: UILabel!
    @IBOutlet weak var phoneText: UILabel!
    var ownerId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId = getUserId()
        
        if(ownerId == nil){
            print("hi profile!")
            ownerId = userId
            //initFCM
        }
        if(userId == ownerId){
            // визуал моего профитля
            
            // set data
        }
        else{
            //визуал др профиля
        }
        updateProfileData(ownerId: ownerId)
    }

    func updateProfileData(ownerId:String) -> Void {
        let user = UserEntity()
        let realm = DBHelper().getDBhelper()
        let usersCursor = realm.objects(TABLE_USERS.self).filter("KEY_ID = '" + ownerId + "'")
        for userCursor in usersCursor{
        user.setName(_name: userCursor.value(forKey: "KEY_NAME_USERS") as! String)
        user.setCity(_city: userCursor.value(forKey: "KEY_CITY_USERS") as! String)
        user.setPhone(_phone: userCursor.value(forKey: "KEY_PHONE_USERS") as! String)
        //setCountOfRates
        //setRating
        }
        setProfileData(_user: user)
    }
    
    func  setProfileData(_user:UserEntity) -> Void {
        nameText.text = _user.getName()
        cityTex.text = _user.getCity()
        phoneText.text = _user.getPhone()
        //get rating
        //set avatar
        //updateServiceList()!
    }
    func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    @IBAction func goToAdditionService(_ sender: Any) {
        let  additionServiceVC = storyboard?.instantiateViewController(withIdentifier: "AdditionService") as! AdditionService
        navigationController?.pushViewController(additionServiceVC, animated: true)
    }
}
