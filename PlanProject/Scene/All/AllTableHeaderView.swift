//
//  AllTableHeaderView.swift
//  PlanProject
//
//  Created by 김진수 on 2/16/24.
//

import UIKit
import SnapKit
import Then

class AllTableHeaderView: UITableViewHeaderFooterView {

    let listTitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textColor = .lightGray
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AllTableHeaderView: ConfigureUIProtocol {
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        self.contentView.addSubview(listTitleLabel)
    }
    
    func configureContraints() {
        self.listTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).inset(10)
        }
    }
}

extension AllTableHeaderView {
    func configureHeaderView(text: String) {
        self.listTitleLabel.text = text
    }
}
