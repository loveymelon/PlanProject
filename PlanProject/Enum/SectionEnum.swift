//
//  SectionEnum.swift
//  PlanProject
//
//  Created by 김진수 on 2/14/24.
//

import Foundation

enum SectionEnum: Int, CaseIterable {
    case memo
    case date
    case tag
    case priority
    case imageAdd
    
    var sectionCount: Int {
        switch self {
        case .memo:
            return 2
        default:
            return 1
        }
    }
    
    var title: String {
        switch self {
        case .date:
            return "마감일"
        case .tag:
            return "태그"
        case .priority:
            return "우선 순위"
        case .imageAdd:
            return "이미지 추가"
        default:
            return ""
        }
    }
    
}
