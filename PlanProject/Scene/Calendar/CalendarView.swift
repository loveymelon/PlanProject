//
//  CalendarView.swift
//  PlanProject
//
//  Created by 김진수 on 2/19/24.
//

import UIKit
import FSCalendar
import Then

class CalendarView: BaseView {
    
    let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300)).then {
        $0.backgroundColor = .white
        $0.scrollDirection = .vertical
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(calendar)
    }
    
    override func configureContraints() {
        self.calendar.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
