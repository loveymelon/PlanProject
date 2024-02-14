//
//  CategoryViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class CategoryViewController: BaseViewController {
    
    lazy var mainView = CategoryView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func delegateDataSource() {
        self.mainView.collectionView.dataSource = self
        self.mainView.collectionView.delegate = self
    }
    
    override func configureNav() {
        self.navigationController?.isToolbarHidden = false
        
        let addToDoButton = UIBarButtonItem(customView: self.mainView.addButton)
        
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(tappedAddListButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.mainView.addButtonFuc = { [self] in
            
            goView()
            
        }
        
        self.toolbarItems = [addToDoButton, flexibleSpace, addList]
    }
    
    
    
    @objc func tappedAddListButton() {
        print(#function)
    }
    
    func goView() {
        let vc = NewToDoViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        self.present(nav, animated: true)
    }

}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainView.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let titleItem = self.mainView.titleArray[indexPath.item]
        let imageItem = self.mainView.imageArray[indexPath.item]
        
        cell.configureCell(title: titleItem, items: imageItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionReusableView.identifier, for: indexPath) as? CustomCollectionReusableView else { return UICollectionReusableView() }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width * 0.1)
    }
    
}
