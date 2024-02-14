//
//  NewToDoViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class NewToDoViewController: BaseViewController {
    
    let mainView = ToDoView()
    
    var dataDic: [String: String] = [:]
    
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
    
    override func configureNav() {
        self.navigationItem.title = "새로운 할 일"
    }
    
    override func delegateDataSource() {
        self.mainView.todoTableView.delegate = self
        self.mainView.todoTableView.dataSource = self
    }
    
    @objc func receivedNotiDate(notification: NSNotification) {
        if let value = notification.userInfo?["Date"] as? String {
            dataDic["Date"] = value
            print(value)
        }
    }
    
    @objc func receivedNotiTag(notification: NSNotification) {
        if let value = notification.userInfo?["Tag"] as? String {
            dataDic["Tag"] = value
        }
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
        
        if indexPath == [0, 0] {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath == [0, 1] {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
            
            cell.memoTextView.delegate = self
            
            return cell
            
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "sectionCell")
            cell.textLabel?.text = self.mainView.titleArray[indexPath.section - 1]
            
            switch indexPath.section {
            case 1:
                cell.detailTextLabel?.text = dataDic["Date"] ?? ""
            case 2:
                cell.detailTextLabel?.text = dataDic["Tag"] ?? ""
            case 3:
                cell.detailTextLabel?.text = dataDic["Priority"] ?? ""
            default:
                print("")
            }
            
            cell.accessoryType = .disclosureIndicator
            
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
                self.dataDic["Priority"] = "\(result)"
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
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
        }
    }
}
