//
//  CategoryView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit
import SnapKit
import Then

final class CategoryView: BaseView {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout()).then {
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        $0.register(CustomCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionReusableView.identifier)
        $0.backgroundColor = .black
    }
    
    lazy var addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.setTitle("새로운 할 일", for: .normal)
        $0.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    let titleArray = ["오늘", "예정", "전체", "깃발 표시", "완료됨"] // enum처리 할 것
    let imageArray = ["calendar.circle", "calendar.circle.fill", "folder.fill", "flag.fill", "checkmark.circle.fill"]
    
    var addButtonFuc: (() -> Void)?
    
    private static func collectionFlowLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 0.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical

        return layout
    }
    
    override func configureHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func configureContraints() {
        self.collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    @objc func tappedAddButton() {
        addButtonFuc?()
    }

}

