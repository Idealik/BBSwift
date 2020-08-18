//
//  RepositoryContainer.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 16.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class RepositoryContainer{
    
    func setupContainer(using container : Container){
        //FIREBASE
        container.register(UserFirebase.self) { _ in UserFirebase()}
        container.register(ServiceFirebase.self) { _ in ServiceFirebase()}
        //REPOSITORIES
        container.register(UserRepository.self) { r in
            UserRepository(userFirebase: r.resolve(UserFirebase.self)!)
        }
        
        container.register(ServiceRepository.self) { r in
            ServiceRepository(serviceFirebase: r.resolve(ServiceFirebase.self)!)
        }
        //INTERACTORS
        container.register(AuthorizationInteractor.self) { r in
            AuthorizationInteractor(userRepository: r.resolve(UserRepository.self)!)
        }
        
        container.register(RegistrationUserInteractor.self) { r in
            RegistrationUserInteractor(userRepository: r.resolve(UserRepository.self)!)
        }
        //PRESENTERS
        container.register(AuthorizationPresenter.self) { r in
            AuthorizationPresenter(authorizationInteractor: r.resolve(AuthorizationInteractor.self)!)
        }
        
        container.storyboardInitCompleted(AuthorizationController.self) {r,c in
            c.authorizationPresenter = r.resolve(AuthorizationPresenter.self)!
        }
    }
}
