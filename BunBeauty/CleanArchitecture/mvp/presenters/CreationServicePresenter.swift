//
//  CreationServicePresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 01.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class CreationServicePresenter:CreationServicePresenterCallback {
    
    
    private let creationServiceView: CreationServiceView
    private let creationServiceServiceInteractor:ICreationServiceServiceInteractor
    private let creationServiceTagInteractor:ICreationServiceTagInteractor
    
    init(creationServiceView: CreationServiceView,
         creationServiceServiceInteractor:CreationServiceServiceInteractor,
         creationServiceTagInteractor:CreationServiceTagInteractor ) {
        self.creationServiceServiceInteractor = creationServiceServiceInteractor
        self.creationServiceTagInteractor = creationServiceTagInteractor
        self.creationServiceView = creationServiceView
    }
    
    func addService(
        name:String,
        description:String,
        cost:Int,
        address:String,
        category:String
    ){
        var service = Service()
        service.name = name
        service.description = description
        service.cost = cost
        service.address = address
        service.category = category
        service.userId = User.getMyId()
        creationServiceServiceInteractor.addService(service: service, creationServicePresenterCallback: self)
    }
    
    func createPhoto(uri:String){
        
    }
    
    func removePhoto(photo:Photo){
        
    }
    
    func addTags(service: Service) {
        creationServiceTagInteractor.addTags(service: service)
    }
    
    func addPhotos(service: Service) {
        
    }
    
    
}
