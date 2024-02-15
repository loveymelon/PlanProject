//
//  PriorityViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    let mainView = PriorityView()
    
    var segValue: ((String) -> Void)?

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
        switch self.mainView.segment.selectedSegmentIndex {
        case 0:
            segValue?("중요")
        case 1:
            segValue?("보통")
        default:
            break
        }
        
//        print(self.mainView.segment.selectedSegmentIndex)
    }

}
