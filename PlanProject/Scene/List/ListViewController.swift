//
//  ListViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/20/24.
//

import UIKit
import RealmSwift

class ListViewController: BaseViewController {
    
    let mainView = ListView()
    let repository = TodoRepository()
    var list: Results<MyList>?
    
    var listSelect: ((MyList) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        list = repository.fetchRealmObject()
    }
    
    override func configureNav() {
        super.configureNav()
        
        self.navigationItem.title = "목록"
    }
    
    override func delegateDataSource() {
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.delegate = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ListCell")
        guard let item = list?[indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let item = list?[indexPath.row] else { return }
        
        cell?.accessoryType = .checkmark
        
        listSelect?(item)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = .none
    }
}
