//
//  TitleTableViewCell.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import SnapKit
import Then

class TitleTableViewCell: UITableViewCell {
    
    let titleTextField = UITextField().then {
        $0.setPlaceholder(string: "제목", color: .gray)
        $0.backgroundColor = .lightGray
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleTableViewCell: ConfigureUIProtocol {
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        self.contentView.addSubview(titleTextField)
    }
    
    func configureContraints() {
        self.titleTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}
