//
//  AllViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/15/24.
//

import UIKit
import RealmSwift

class AllViewController: BaseViewController {
    
    let mainView = AllView()
    
    var titleText: String?
    var buttonEvent: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func configureNav() {
        self.navigationItem.title = "전체"
        self.navigationController?.navigationBar.backgroundColor = .blue
    }
    
    override func delegateDataSource() {
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
    }
    
    @objc func tappedCheckButton(sender: UIButton) {
        buttonEvent?()
        print(#function)
    }

}

extension AllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTableViewCell.identifier) as? AllTableViewCell else { return UITableViewCell() }
        
        cell.configureUI()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllTableHeaderView.identifier) as? AllTableHeaderView else { return UIView() }
        
        headerView.configureHeaderView(text: titleText ?? "타이틀 없음")
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.width * 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
}
