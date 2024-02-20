//
//  AllViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/15/24.
//

import UIKit
import RealmSwift
import FSCalendar

class AllViewController: BaseViewController {
    
    let mainView = AllView()
    
    var titleText: String?
    let repository = TodoRepository()
    var list: Results<TodoRealm>?
    
    var res: List<TodoRealm>?
    
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
        
        let menuItems: [UIAction] = [
            UIAction(title: "마감일순", handler: { [self] _ in
                list = repository.fetchFilterItem(filter: .date)
                mainView.tableView.reloadData()
            }),
            UIAction(title: "완료순", handler: { [self] _  in
                list = repository.fetchFilterItem(filter: .complete)
                mainView.tableView.reloadData()
            }),
            UIAction(title: "우선순위순", handler: { [self] _ in
                list = repository.fetchFilterItem(filter: .priority)
                mainView.tableView.reloadData()
            }),
            UIAction(title: "전체보기", handler: { [self] _ in
                list = repository.fetchFilterItem(filter: .none)
                mainView.tableView.reloadData()
            })
        ]
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        let leftButton = UIButton()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(tappedBackButton))
        
        leftButton.setImage(UIImage(systemName: "calendar.circle"), for: .normal)
        leftButton.addTarget(self, action: #selector(tappedLeftBarButton), for: .touchUpInside)
        
        rightBarButton.menu = UIMenu(children: menuItems)
        
        let barLeftButton = UIBarButtonItem(customView: leftButton)
        
        self.navigationItem.leftBarButtonItems = [backButton, barLeftButton]
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    override func delegateDataSource() {
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
        
    }
    
    @objc func tappedLeftBarButton() {
        let vc = CalendarViewController()
        
        vc.calendarData = { [self] result in
            list = result
            mainView.tableView.reloadData()
        }
        
        present(vc, animated: true)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(list?.count)
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTableViewCell.identifier) as? AllTableViewCell else { return UITableViewCell() }
        guard let item = list?[indexPath.row] else { return UITableViewCell() }
        
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


