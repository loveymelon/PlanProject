//
//  Date+Extension.swift
//  PlanProject
//
//  Created by 김진수 on 2/17/24.
//

import UIKit


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. dd."
        return dateFormatter.string(from: self)
    }
}


