//
//  CategoryViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class CategoryViewController: BaseViewController {
    
    var mainView = CategoryView()
    let repository = TodoRepository()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mainView.collectionView.reloadData()
    }
    
    override func delegateDataSource() {
        self.mainView.collectionView.dataSource = self
        self.mainView.collectionView.delegate = self
    }
    
    override func configureNav() {
        self.navigationController?.isToolbarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        
        let addToDoButton = UIBarButtonItem(customView: self.mainView.addButton)
        
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.mainView.addButtonFuc = { [self] in
            
            goView()
            
        }
        
        self.toolbarItems = [addToDoButton, flexibleSpace, addList]
    }
    
    func goView() {
        let vc = NewToDoViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }

}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let categoryItem = CategoryEnum.allCases[indexPath.item]
        
        cell.configureCell(item: categoryItem, count: repository.realmCount())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionReusableView.identifier, for: indexPath) as? CustomCollectionReusableView else { return UICollectionReusableView() }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        let vc = AllViewController()
        
        vc.titleText = cell.categoryLabel.text
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
