//
//  CategoryCollectionViewCell.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import Then
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryImageView = UIImageView()
    let categoryLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    let categoryTotalLabel = UILabel().then {
        $0.isHidden = false
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textColor = .white
        $0.text = "0"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCollectionViewCell: ConfigureUIProtocol {
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        self.contentView.addSubview(categoryImageView)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(categoryTotalLabel)
    }
    
    func configureContraints() {
        self.categoryImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.leading.equalTo(self.contentView).inset(10)
        }
        
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryImageView.snp.bottom).offset(10)
            make.leading.bottom.equalTo(10)
        }
        
        self.categoryTotalLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.contentView).inset(10)
            make.height.equalTo(25)
        }
    }
    
}

extension CategoryCollectionViewCell {
    func configureCell(item: CategoryEnum, count: Int) {
        self.categoryLabel.text = item.title
        self.categoryImageView.image = UIImage(systemName: item.image)
        self.categoryImageView.tintColor = item.imageColor
        self.categoryTotalLabel.text = "\(count)"
    }
}
