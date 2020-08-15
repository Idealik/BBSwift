//
//  ProfilePresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class ProfilePresenter {
    
    private let profileUserInteractor:IProfileUserInteractor
    private let profileServiceInteractor:IProfileServiceInteractor
    private let profileSubscriberInteractor:IProfileSubscriberInteractor
    private let profileSubscriptionInteractor:IProfileSubscriptionInteractor
    private let profileDialogInteractor:IProfileDialogInteractor
    private let profileView:ProfileView

    init(
         profileUserInteractor:ProfileUserInteractor,
         profileServiceInteractor:ProfileServiceInteractor,
         profileSubscriberInteractor:ProfileSubscriberInteractor,
         profileSubscriptionInteractor:ProfileSubscriptionInteractor,
         profileDialogInteractor:ProfileDialogInteractor,
         profileView:ProfileView
    ) {
        self.profileUserInteractor =  profileUserInteractor
        self.profileServiceInteractor =  profileServiceInteractor
        self.profileSubscriberInteractor =  profileSubscriberInteractor
        self.profileSubscriptionInteractor =  profileSubscriptionInteractor
        self.profileDialogInteractor =  profileDialogInteractor
        self.profileView = profileView
        return
    }
    
    
}
