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
        $0.register(AllTableViewCell.self, forCellReuseIdentifier: AllTableViewCell.identifier)
        $0.register(AllTableHeaderView.self, forHeaderFooterViewReuseIdentifier: AllTableHeaderView.identifier)
        $0.backgroundColor = .black
        $0.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width:CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude)))
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        $0.rowHeight = UITableView.automaticDimension
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
