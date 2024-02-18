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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        switch self.mainView.segment.selectedSegmentIndex {
        case 0:
            segValue?("!!!")
        case 1:
            segValue?("!!")
        case 2:
            segValue?("!")
        default:
            break
        }
    }

}
