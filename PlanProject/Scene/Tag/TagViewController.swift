//
//  TagViewController.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import UIKit

class TagViewController: BaseViewController {
    
    let mainView = TagView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("TagReceived"), object: nil, userInfo: ["Tag": self.mainView.tagTextView.resolveHashTags()])
    }
    
    override func addTargetEvent() {
        self.mainView.tagTextView.delegate = self
    }

}

extension TagViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == "스페이스바로 나누면 #가 완성됩니다" {
            textView.text = nil
            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "스페이스바로 나누면 #가 완성됩니다"
            textView.textColor = .lightGray
        }
    }
    
}
