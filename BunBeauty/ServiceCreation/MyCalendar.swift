//
//  MyCalendar.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 29/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
class MyCalendar: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private let WEEKS_COUNT = 4
    private let DAYS_COUNT = 7
    var indexDate = 0
    var dates = [Date]()

    @IBOutlet weak var calendarCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dates = generateDates(startDate: Date(), addbyUnit: Calendar.Component.day, value: 28)
    }
    //create calendar
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 7
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size+10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WEEKS_COUNT*DAYS_COUNT
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarCollection.dequeueReusableCell(withReuseIdentifier: "dayIdCell", for: indexPath) as! DayCell
        cell.dayText.text = WorkWithTimeApi.getDateInFormatDM(date: dates[indexDate])
        indexDate += 1
        return cell
    }
    func generateDates(startDate :Date?, addbyUnit:Calendar.Component, value : Int) -> [Date] {
        var dates = [Date]()
        var date = startDate!
        let endDate = Calendar.current.date(byAdding: addbyUnit, value: value, to: date)!
        while date < endDate {
            date = Calendar.current.date(byAdding: addbyUnit, value: 1, to: date)!
            dates.append(date)
        }
        return dates
    }
    private func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    
}
