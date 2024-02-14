//
//  DateViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func addTargetEvent() {
        self.mainView.datePicker.addTarget(self, action: #selector(valueChangeDatePicker), for: .valueChanged)
    }
    
    @objc func valueChangeDatePicker(sender: UIDatePicker) {
        let selectedDate: String = self.mainView.dateFormatter.string(from: sender.date)
        print(selectedDate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("DateReceived"), object: nil, userInfo: ["Date": self.mainView.dateFormatter.string(from: self.mainView.datePicker.date)])
    }
    
}
