//
//  TagView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import Then
import SnapKit

class TagView: BaseView {
    
    let tagTextField = UITextField().then {
        $0.setPlaceholder(string: "입력하세요", color: .white)
        $0.textColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(tagTextField)
    }
    
    override func configureContraints() {
        self.tagTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
    }
    
}
