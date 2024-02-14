//
//  ToDoView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import Then
import SnapKit

class ToDoView: BaseView {

    let todoTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .darkGray
        $0.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        $0.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
    }
    
    let titleArray = ["마감일", "태그", "우선 순위", "이미지 추가"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(todoTableView)
    }
    
    override func configureContraints() {
        self.todoTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
