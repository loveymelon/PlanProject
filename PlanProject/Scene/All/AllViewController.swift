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
    
    var realmData: Results<TodoRealm>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        
        self.realmData = realm.objects(TodoRealm.self)
        
        self.mainView.tableView.reloadData()
    }
    
    override func configureNav() {
        self.navigationItem.title = "전체"
        
        let date = UIAction(title: "날짜") { [self] _ in
            let realm = try! Realm()
            
            realmData = realm.objects(TodoRealm.self).sorted(byKeyPath: "date", ascending: true)
            
            self.mainView.tableView.reloadData()
        }
        
        let title = UIAction(title: "제목") { [self] _ in
            let realm = try! Realm()
            
            realmData = realm.objects(TodoRealm.self).sorted(byKeyPath: "title", ascending: false)
            
            self.mainView.tableView.reloadData()
        }
        
        let priority = UIAction(title: "우선 순위") { [self] _ in
            let realm = try! Realm()
            
            realmData = realm.objects(TodoRealm.self).sorted(byKeyPath: "priority", ascending: true)
            
            self.mainView.tableView.reloadData()
        }
        
        let buttonMenu = UIMenu(children: [date, title, priority])
        
        self.mainView.filterButton.menu = buttonMenu
        let rightButton = UIBarButtonItem(customView: self.mainView.filterButton)
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func delegateDataSource() {
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
    }

}

extension AllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableCell") as! UITableViewCell
        let row = self.realmData[indexPath.row]
        cell.textLabel?.text = "\(row.tag)"
        
        return cell
    }
    
}
