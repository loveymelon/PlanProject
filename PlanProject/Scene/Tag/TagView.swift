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
    
    let tagTextView = UITextView().then {
        $0.text = "스페이스바로 나누면 #가 완성됩니다"
        $0.textColor = .lightGray
        $0.backgroundColor = .black
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(tagTextView)
    }
    
    override func configureContraints() {
        self.tagTextView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
