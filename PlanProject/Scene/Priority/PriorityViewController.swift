//
//  PriorityViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    let mainView = PriorityView()
    
    var segValue: ((Int) -> Void)?

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func addTargetEvent() {
        self.mainView.segment.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
    }
    
    @objc func segValueChanged() {
        segValue?(self.mainView.segment.selectedSegmentIndex)
//        print(self.mainView.segment.selectedSegmentIndex)
    }

}
