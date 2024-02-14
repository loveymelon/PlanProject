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
        
    }
    
    func configureContraints() {

        self.memoTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.verticalEdges.horizontalEdges.equalToSuperview()
        }
        
    }
}

