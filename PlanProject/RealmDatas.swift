//
//  RealmDatas.swift
//  PlanProject
//
//  Created by 김진수 on 2/21/24.
//

import Foundation
import RealmSwift

class RealmDatas {
    var linkData: List<TodoRealm>?
    var result: Results<TodoRealm>?
    
    private var todoRealmData: TodoRealm?
    private let repository = TodoRepository()
    
    func dataCount() -> Int {
        if let linkCount = linkData?.count {
            return linkCount
        } else {
            guard let resultCount = result?.count else { return 0 }
            return resultCount
        }
    }
    
    func fetchRealmDatas(index: Int) -> TodoRealm? {
        todoRealmData = linkData?[index]
        if todoRealmData == nil {
            todoRealmData = result?[index]
        }
        
        return todoRealmData
    }
    
    func fetchFilter(filter: FilterEnum) {
        result = repository.fetchFilterItem(filter: filter)
    }
    
}
