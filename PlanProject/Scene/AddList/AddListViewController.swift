//
//  AddListViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/20/24.
//

import UIKit
import RealmSwift

class AddListViewController: BaseViewController {
    
    let mainView = AddListView()
    let repository = TodoRepository()
    
    var titleText: String = ""
    var complete: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureNav() {
        let cancleButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tappedCancleButton))
        let completeButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(tappedCompleteButton))
        
        self.navigationItem.leftBarButtonItem = cancleButton
        self.navigationItem.rightBarButtonItem = completeButton
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.navigationItem.title = "새로운 목록"
    }
    
    override func delegateDataSource() {
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
    }
    
    @objc func tappedCancleButton() {
        dismiss(animated: true)
    }
    
    @objc func tappedCompleteButton() {

        let myListData = MyList(title: titleText, date: Date())
        
        do {
            try repository.createItem(item: myListData)
            complete?()
        } catch {
            print(error)
        }
        
        dismiss(animated: true)
    }

}

extension AddListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddListTableViewCell.identifier, for: indexPath) as? AddListTableViewCell else { return UITableViewCell() }
        
        cell.titleTextField.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.width * 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
}

extension AddListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.navigationItem.rightBarButtonItem?.isEnabled = textField.text != "" ? true : false
        self.titleText = textField.text ?? ""
        return true
    }
}
