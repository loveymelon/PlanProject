//
//  TableViewCell.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import Then
import SnapKit

class MemoTableViewCell: UITableViewCell {
    
    let memoTextView = UITextView().then {
        $0.text = "메모"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .lightGray
    }
    
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

extension MemoTableViewCell: ConfigureUIProtocol {
    
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        
        self.contentView.addSubview(memoTextView)
        self.contentView.addSubview(titleTextField)
        
    }
    
    func configureContraints() {

        self.memoTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}

extension MemoTableViewCell {
    func configureCell(index: Int) {
        
        if index == 0 {
            self.memoTextView.isHidden = true
            self.titleTextField.isHidden = false
        } else {
            self.memoTextView.isHidden = false
            self.titleTextField.isHidden = true
        }
        
    }
}
