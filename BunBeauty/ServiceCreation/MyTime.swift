//
//  MyTime.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit

class MyTime: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var scheduleCollection: UICollectionView!
    
    private let WORKER = "worker"
    private let USER = "user"
    
    var serviceId:String!
    var workingDaysId:String!
    var userId:String!
    var statusUser:String!
    private var selectedTime:String!
    private var myOrderTime:String!
    private var workingHours = [String]()
    private var removedHours = [String]()
    private var counterForCell = 0
    private var hour = 0
    private var worker:Worker!
    private var user:User!
    
    private var isNullTime:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if statusUser == WORKER{
            worker = Worker(userId:userId,serviceId: serviceId)
        }else{
            user = User(userId: userId, serviceId: serviceId, workingDaysId: workingDaysId)
            myOrderTime = checkMyOrder()
        }
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        if statusUser == WORKER{
            if workingHours.count > 0 {
                worker.addTime(workingDaysId:workingDaysId, workingHours: workingHours)
                workingHours.removeAll()
                alertEvertingDone()
            }
            
            if removedHours.count > 0 {
                //check is free time
                worker.deleteTime(workingDaysId: workingDaysId, removedHours: removedHours)
                alertEvertingDone()
                removedHours.removeAll()
            }
        }else{
            if workingHours.count == 1 {
                //is free timev else selectbtnsforuser
                let workingTimeId = WorkWithLocalStorageApi.getWorkingTimeId(time: workingHours[0], workingDaysId: workingDaysId)
                user.makeOrder(workingTimeId:workingTimeId)
                scheduleCollection.reloadData()
                workingHours.removeAll()
                //attention
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = scheduleCollection.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCell
        cell = setDefaultCell(cell: cell) as! TimeCell
        
        var minute:String?
        if counterForCell%2 == 0 && counterForCell != 0{
            hour+=1
        }
        counterForCell+=1
        
        if isNullTime{
            isNullTime = false
            minute = "00"
            
        }else{
            isNullTime = true
            minute = "30"
        }
        var time = String(hour) + ":" + minute!
        cell.timeCell.text = time
        
        if statusUser == WORKER{
            //select buttons for worker
            if WorkWithLocalStorageApi.checkCurrentTimeForWorker(workingDaysId: workingDaysId, time: time){
                cell = pressedButton(cell: cell)
                //if !isFreeTime(time)
            }
        }
        else{
            //select buttons for user
            if time.count == 4{
                time = "0"+time
            }
            
            if myOrderTime != nil{
                // have order
                if myOrderTime! == time{
                    // my order select
                    cell.timeCell.isUserInteractionEnabled = false
                    return pressedButton(cell: cell)
                }
                else{
                    return noEnableCell(cell: cell)
                }
            }
            else{
                // dont have order
                if !isFreeTime(time: time){
                    return noEnableCell(cell: cell)
                }
            }
        }
        return cell
    }
    
    private func checkMyOrder()->String?{
        let realm = DBHelper().getDBhelper()
        let ordersCursor = realm.objects(TABLE_ORDERS.self).filter("KEY_USER_ID == %@ AND KEY_IS_CANCELED_ORDERS == %@", userId!, "false")
        for order in ordersCursor{ 
           let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_ID == %@", order.KEY_WORKING_TIME_ID_ORDERS ?? "0")
        }
        return nil
    }
    
    private func isFreeTime(time:String)->Bool{
        let realm = DBHelper().getDBhelper()
        
        let timesCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_TIME_WORKING_TIME == %@ AND KEY_WORKING_DAYS_ID_WORKING_TIME == %@", time, workingDaysId!)
        
        for _ in timesCursor{
            return true
        }
        return false
    }
    
    private func noEnableCell(cell:UICollectionViewCell) -> UICollectionViewCell {
        let curCell = cell as! TimeCell
        curCell.isUserInteractionEnabled = false
        curCell.timeCell.isEnabled = false
        return curCell
    }
    private func setDefaultCell(cell:UICollectionViewCell) -> UICollectionViewCell {
        let curCell = cell as! TimeCell
        curCell.layer.backgroundColor = UIColor.white.cgColor
        curCell.timeCell.textColor = UIColor.black
        curCell.isUserInteractionEnabled = true
        curCell.timeCell.isEnabled = true
        return curCell
    }
    
    //select day
    var selectedIndexPath: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cell = scheduleCollection.cellForItem(at: indexPath) as! TimeCell
        let curSelectedTime = cell.timeCell.text!
        if statusUser == WORKER{
            if cell.tag == 1{
                //selected
                cell.layer.backgroundColor = UIColor.white.cgColor
                if let index = workingHours.firstIndex(of: curSelectedTime) {
                    workingHours.remove(at: index)
                }
                if curSelectedTime.count == 4{
                    removedHours.append("0"+curSelectedTime)
                }else{
                    removedHours.append(curSelectedTime)
                }
                cell.tag = 0
            }else{
                //unselected
                if curSelectedTime.count == 4{
                    workingHours.append("0"+curSelectedTime)
                }else{
                    workingHours.append(curSelectedTime)
                }
                if let index = removedHours.firstIndex(of: curSelectedTime) {
                    removedHours.remove(at: index)
                }
                cell = pressedButton(cell: cell)
            }
        }else{
            cell.layer.backgroundColor = UIColor.yellow.cgColor
            let curSelectedTime = cell.timeCell.text
            workingHours.removeAll()
            if(selectedTime == curSelectedTime){
                //нажали на тот же день
                cell.layer.backgroundColor = UIColor.white.cgColor
                self.selectedIndexPath = nil
                selectedTime = nil;
            }
            else{
                selectedTime = curSelectedTime
                if curSelectedTime!.count == 4{
                    workingHours.append("0"+curSelectedTime!)
                }else{
                    workingHours.append(curSelectedTime!)
                }
            }
        }
        
        self.selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if statusUser == USER{
            let cell = scheduleCollection.cellForItem(at: indexPath)
            
            cell!.layer.backgroundColor = UIColor.white.cgColor
            
            self.selectedIndexPath = nil
        }
    }
    
    private func pressedButton(cell:TimeCell) -> TimeCell {
        cell.tag = 1
        cell.layer.backgroundColor = UIColor.yellow.cgColor
        return cell
    }
    
    private func alertEvertingDone()  {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-125, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        if statusUser == WORKER{
            toastLabel.text = "Расписание обновлено"
        }
        else{
            toastLabel.text = "Вы успешно записались"
        }
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
