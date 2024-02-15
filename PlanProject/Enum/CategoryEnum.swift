//
//  CategoryEnum.swift
//  PlanProject
//
//  Created by 김진수 on 2/15/24.
//

import Foundation
import RealmSwift

enum CategoryEnum: CaseIterable {
    case today
    case plan
    case all
    case flag
    case complete
    
    var title: String {
        switch self {
        case .today:
            return "오늘"
        case .plan:
            return "예정"
        case .all:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .complete:
            return "완료됨"
        }
    }
    
    var image: String {
        switch self {
        case .today:
            return "calendar.circle"
        case .plan:
            return "calendar.circle.fill"
        case .all:
            return "folder.fill"
        case .flag:
            return "flag.fill"
        case .complete:
            return "checkmark.circle.fill"
        }
    }
    
    var realmCount: Int {
        let realm = try! Realm()
        var list: Results<TodoRealm>!
        
        list = realm.objects(TodoRealm.self)
        
        return list.count
    }

}
