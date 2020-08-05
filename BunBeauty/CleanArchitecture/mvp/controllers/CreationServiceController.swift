//
//  AdditionService.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import iOSDropDown

class CreationServiceController: UIViewController, CreationServiceView {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var costText: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var categorySpinner: DropDown!
    
    
    var creationServiceServiceInteractor:CreationServiceServiceInteractor  = CreationServiceServiceInteractor(serviceRepository: ServiceRepository.getInstance())
    var creationServiceTagInteractor:CreationServiceTagInteractor  = CreationServiceTagInteractor()
    var creationServicePresenter:CreationServicePresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categorySpinner.optionArray = Strings.categories
        
        creationServicePresenter = CreationServicePresenter(creationServiceView: self, creationServiceServiceInteractor: creationServiceServiceInteractor, creationServiceTagInteractor: creationServiceTagInteractor)
    }
    
    @IBAction func addServiceBtn(_ sender: Any) {
        creationServicePresenter?.addService(name: nameText.text ?? "", description: descriptionInput.text ?? "", cost: Int(costText.text ?? "") ?? 0, address: addressInput.text ?? "", category: categorySpinner.text ?? "")
    }
    
    
    /*
     создание диалога
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
          
          
     */
    
}
