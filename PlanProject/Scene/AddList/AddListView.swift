//
//  AddListView.swift
//  PlanProject
//
//  Created by 김진수 on 2/20/24.
//

import UIKit
import Then
import SnapKit

class AddListView: BaseView {

    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(AddListTableViewCell.self, forCellReuseIdentifier: AddListTableViewCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width:CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude)))
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureContraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
