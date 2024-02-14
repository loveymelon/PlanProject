//
//  DateView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class DateView: BaseView {
    
    let datePicker = UIDatePicker(frame: .zero).then {
        $0.backgroundColor = .white
    }
    
    let dateFormatter: DateFormatter = DateFormatter().then { 
        $0.dateFormat = "yyyy/MM/dd hh:mm"
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(datePicker)
    }
    
    override func configureContraints() {
        self.datePicker.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
    }
    
}
