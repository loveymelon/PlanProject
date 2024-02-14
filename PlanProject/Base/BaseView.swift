//
//  BaseView.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class BaseView: UIView, ConfigureUIProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        configureHierarchy()
        configureContraints()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureContraints() {
        
    }

}
