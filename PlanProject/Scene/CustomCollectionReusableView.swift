//
//  CustomCollectionReusableView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import SnapKit
import Then

final class CustomCollectionReusableView: UICollectionReusableView {
    
    private let categoryLabel = UILabel().then {
        $0.text = "전체"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomCollectionReusableView: ConfigureUIProtocol {
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        self.addSubview(categoryLabel)
    }
    
    func configureContraints() {
        self.categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    
}
