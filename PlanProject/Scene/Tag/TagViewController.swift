//
//  TagViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class TagViewController: UIViewController {
    
    let mainView = TagView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("TagReceived"), object: nil, userInfo: ["Tag": self.mainView.tagTextField.text ?? ""])
    }

}
