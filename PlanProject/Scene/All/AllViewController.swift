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
    let repository = TodoRepository()
    var list: Results<TodoRealm>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = repository.fetchItem(filter: .none)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func configureNav() {
        self.navigationItem.title = "전체"
        
        let menuItems: [UIAction] = [
            UIAction(title: "마감일순", handler: { [self] _ in
                list = repository.fetchItem(filter: .date)
                mainView.tableView.reloadData()
            }),
            UIAction(title: "완료순", handler: { [self] _  in
                list = repository.fetchItem(filter: .complete)
                mainView.tableView.reloadData()
            }),
            UIAction(title: "우선순위순", handler: { [self] _ in
                list = repository.fetchItem(filter: .priority)
                mainView.tableView.reloadData()
            }),
            UIAction(title: "전체보기", handler: { [self] _ in
                list = repository.fetchItem(filter: .none)
                mainView.tableView.reloadData()
            })
        ]
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        
        rightBarButton.menu = UIMenu(children: menuItems)
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func delegateDataSource() {
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
    }
    
}

extension AllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTableViewCell.identifier) as? AllTableViewCell else { return UITableViewCell() }
        let item = list[indexPath.row]
        
        cell.configureCell(index: indexPath.row, item: item)
        
        cell.errorHandler = { error, text in
            switch error {
            case RealmError.CreateFail:
                print("error")
            case RealmError.UpdateFail(text: text):
                print("error")
            case RealmError.DeleteFail:
                print("error")
            default:
                break
            }
        }
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { [self] (_, _, success: @escaping (Bool) -> Void) in
            do {
                try repository.deleteItem(index: indexPath.row)
                self.mainView.tableView.reloadData()
            } catch {
                print(error)
            }
            
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

