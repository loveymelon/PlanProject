//
//  AllTableViewCell.swift
//  PlanProject
//
//  Created by 김진수 on 2/16/24.
//

import UIKit
import Then
import SnapKit

class AllTableViewCell: UITableViewCell {
    
    let checkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "circle"), for: .normal)
        $0.imageView?.tintColor = .darkGray
    }
    
    let priorityLabel = UILabel().then {
        $0.textColor = .systemBlue
        $0.font = .systemFont(ofSize: 16)
    }
    
    let memoTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18)
    }
    
    let titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 5
        $0.alignment = .fill
    }
    
    let memoLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 15)
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 15)
    }
    
    let tagLabel = UILabel().then {
        $0.textColor = .cyan
        $0.font = .systemFont(ofSize: 15)
    }
    
    let dateTagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 5
        $0.alignment = .fill
    }
    
    let totalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 2
        $0.alignment = .leading
    }
    
    var errorHandler: ((Error, String) -> Void)?
    let repository = TodoRepository()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .black
        
        configureUI()
        
        self.checkButton.addTarget(self, action: #selector(tappedCheckButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedCheckButton() {
        print(#function, self.checkButton.isSelected)
        self.checkButton.isSelected = !self.checkButton.isSelected
        
        if checkButton.isSelected {
            checkButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            checkButton.imageView?.tintColor = .yellow
            do {
                print(checkButton.isSelected)
                try repository.updateItem(index: self.checkButton.tag, updateData: .complete, complete: self.checkButton.isSelected)
            } catch {
                errorHandler?(error, "")
            }
        } else {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            checkButton.imageView?.tintColor = .lightGray
            
            do {
                try repository.updateItem(index: self.checkButton.tag, updateData: .complete, complete: self.checkButton.isSelected)
            } catch {
                errorHandler?(error, "")
            }
        }
        
        
    }
    
}

extension AllTableViewCell: ConfigureUIProtocol {
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        self.contentView.addSubview(checkButton)
    
        [priorityLabel, memoTitleLabel].forEach { item in
            if item.text?.isEmpty == false {
                self.titleStackView.addArrangedSubview(item)
            }
        }
        
        [dateLabel, tagLabel].forEach { item in
            if item.text?.isEmpty == false {
                self.dateTagStackView.addArrangedSubview(item)
            }
        }
        
        [titleStackView, memoLabel, dateTagStackView].forEach { item in
            if let label = item as? UILabel {
                if label.text?.isEmpty == false {
                    self.totalStackView.addArrangedSubview(label)
                }
            } else {
                self.totalStackView.addArrangedSubview(item)
            }
        }
        
        self.contentView.addSubview(totalStackView)
        
    }
    
    func configureContraints() {
        self.checkButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(22)
        }
        
        self.priorityLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        self.memoTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        self.memoLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        self.tagLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        self.totalStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.checkButton.snp.trailing).offset(10)
            make.top.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension AllTableViewCell {
    func configureCell(index: Int, item: TodoRealm) {
        self.priorityLabel.text = item.priority
        self.memoTitleLabel.text = item.title
        self.memoLabel.text = item.memo
        self.dateLabel.text = item.date?.toString()
        self.tagLabel.text = item.tag
        
        self.checkButton.tag = index
        self.checkButton.isSelected = item.complete
        
        if self.checkButton.isSelected {
            checkButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            checkButton.imageView?.tintColor = .yellow
        } else {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            checkButton.imageView?.tintColor = .lightGray
        }
        configureHierarchy()
    }
}
