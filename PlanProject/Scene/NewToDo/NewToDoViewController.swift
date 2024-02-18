//
//  NewToDoViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import RealmSwift

enum NotificationError: Error {
    
}

class NewToDoViewController: BaseViewController {
    
    let mainView = ToDoView()
    
    var dataDic: [String: String] = [:]
    let repository = TodoRepository()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotiDate), name: NSNotification.Name("DateReceived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotiTag), name: NSNotification.Name("TagReceived"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mainView.todoTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dataDic.removeAll()
    }
    
    override func configureNav() {
        self.navigationItem.title = "새로운 할 일"
        
        // 아래 UIBarButtonItem을 View부분으로 빼는 것을 고려하였지만 addTarget을 호출하기 위해서는 lazy키워드를 써야된다는 것에 뷰컨으로 남겨뒀습니다.
        let rightButton = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(tappedRightButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tappedLeftButton))
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func delegateDataSource() {
        self.mainView.todoTableView.delegate = self
        self.mainView.todoTableView.dataSource = self
    }
    
    @objc func receivedNotiDate(notification: NSNotification) {
        if let value = notification.userInfo?["Date"] as? String {
            dataDic["Date"] = value
        }
    }
    
    @objc func receivedNotiTag(notification: NSNotification) {
        if let value = notification.userInfo?["Tag"] as? String {
            dataDic["Tag"] = value
        }
    }
    
    @objc func tappedLeftButton() {
        self.dismiss(animated: true)
    }
    
    @objc func tappedRightButton() {
        

        guard let title = dataDic["Title"] else { return }
        var date: Date?
        
        let memo = dataDic["Memo"]
        let tag = dataDic["Tag"]
        let priority = dataDic["Priority"]

        if let tempDate = dataDic["Date"] {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. M. dd."
            
            date = dateFormatter.date(from: tempDate)!
        }
        
        
        let item = TodoRealm(title: title, memo: memo, date: date, tag: tag, priority: priority, complete: false)
        
        do{
            try repository.createItem(item: item)
        } catch {
            print("error", error)
        }
        
        self.dismiss(animated: true)
    }
    
}

extension NewToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return SectionEnum.allCases[section].sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
            
            cell.memoTextView.delegate = self
            cell.titleTextField.delegate = self
            
            let titleText = dataDic["Title"] ?? ""
            let memoText = dataDic["Memo"] ?? "메모"
            
            cell.configureCell(index: indexPath.row, title: titleText, memo: memoText)
            
            dataDic["Title"] = titleText
            dataDic["Memo"] = memoText
            
            return cell
            
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "sectionCell")

            cell.textLabel?.text = SectionEnum.allCases[indexPath.section].title
            cell.accessoryType = .disclosureIndicator

            switch SectionEnum(rawValue: indexPath.section) {
            case .date:
                cell.detailTextLabel?.text = dataDic["Date"] ?? ""
            case .tag:
                cell.detailTextLabel?.text = dataDic["Tag"] ?? ""
            case .priority:
                cell.detailTextLabel?.text = dataDic["Priority"] ?? ""
            default:
                break
            }

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        switch indexPath.section {
        case 1:
            let vc = DateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TagViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = PriorityViewController()
            vc.segValue = { result in
                print(result)
                self.dataDic["Priority"] = result
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section == 0 {
        case _ where indexPath.item == 1:
            return 100
        default:
            return 40
        }
    }
    
}

extension NewToDoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "메모" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "메모"
            textView.textColor = .lightGray
        } else {
            dataDic["Memo"] = textView.text
        }
    }
}

extension NewToDoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        dataDic["Title"] = textField.text
        checkDicData()
    }
}

extension NewToDoViewController {
    func checkDicData() {
        if dataDic["Title"] != "" {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
