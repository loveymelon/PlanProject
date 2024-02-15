//
//  AllView.swift
//  PlanProject
//
//  Created by 김진수 on 2/15/24.
//

import UIKit
import SnapKit
import Then

class AllView: BaseView {
    
    let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "AllTableCell")
        $0.rowHeight = 80
        $0.backgroundColor = .lightGray
    }
    
    lazy var filterButton = UIButton().then {
        $0.setTitle("...버튼", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tappedFilterButton), for: .touchUpInside)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.addSubview(self.tableView)
    }
    
    override func configureContraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func tappedFilterButton() {
        print(#function)
    }
}
