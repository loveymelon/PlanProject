//
//  PriorityView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import SnapKit
import Then

class PriorityView: BaseView {
    
    let segment = UISegmentedControl(items: ["aaa", "bbb"]).then {
        $0.backgroundColor = .white
        $0.selectedSegmentTintColor = .red
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(segment)
    }
    
    override func configureContraints() {
        self.segment.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
    }
    
}
