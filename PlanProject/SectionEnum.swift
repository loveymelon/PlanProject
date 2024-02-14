//
//  SectionEnum.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import Foundation

enum SectionEnum: CaseIterable {
    case titleMemo
    case memo
    case date
    case tag
    case priority
    case imageAdd
    
    var sectionCount: Int {
        switch self {
        case .titleMemo, .memo:
            return 2
        default:
            return 1
        }
    }
}