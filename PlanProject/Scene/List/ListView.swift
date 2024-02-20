//
//  ListView.swift
//  PlanProject
//
//  Created by 김진수 on 2/20/24.
//

import UIKit
import Then
import SnapKit

class ListView: BaseView {

    let tableView = UITableView().then {
        $0.backgroundColor = .lightGray
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
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
