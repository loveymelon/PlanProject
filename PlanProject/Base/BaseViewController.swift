//
//  BaseViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        delegateDataSource()
        addTargetEvent()
        
        self.view.backgroundColor = .black
    }
    
    func configureNav() {
        
    }
    
    func delegateDataSource() {
        
    }
    
    func addTargetEvent() {
        
    }
}
