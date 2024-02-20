//
//  AddListTableViewCell.swift
//  PlanProject
//
//  Created by 김진수 on 2/20/24.
//

import UIKit
import SnapKit
import Then

class AddListTableViewCell: UITableViewCell {
    
    let circleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "list.bullet.circle.fill")
        $0.tintColor = .systemBlue
        $0.backgroundColor = .clear
    }
    
    let titleTextField = UITextField().then {
        $0.setPlaceholder(string: "목록 이름", color: .lightGray)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
        $0.textAlignment = .center
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .darkGray
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddListTableViewCell: ConfigureUIProtocol {
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        self.contentView.addSubview(circleImageView)
        self.contentView.addSubview(titleTextField)
    }
    
    func configureContraints() {
        
        self.circleImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.contentView.safeAreaLayoutGuide).inset(130)
            make.height.equalTo(self.circleImageView.snp.width)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide).inset(10)
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.contentView.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(self.circleImageView.snp.bottom).offset(10)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    
}
