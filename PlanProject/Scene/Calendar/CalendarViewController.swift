//
//  CalendarViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/19/24.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: BaseViewController {
    
    let mainView = CalendarView()
    let repository = TodoRepository()
    
    var calendarData: ((Results<TodoRealm>?) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func delegateDataSource() {
        self.mainView.calendar.dataSource = self
        self.mainView.calendar.delegate = self
    }
    

}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendarData?(repository.fetchDateItem(filter: date))
        
        self.dismiss(animated: true)
    }
    

}
