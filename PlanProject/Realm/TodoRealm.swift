//
//  TodoModel.swift
//  PlanProject
//
//  Created by 김진수 on 2/15/24.
//

import Foundation
import RealmSwift

class MyList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var date: Date
    
    @Persisted var detail: List<TodoRealm>
    
    convenience init(title: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
    }
}

class TodoRealm: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var date: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?
    @Persisted var complete: Bool
    
    @Persisted(originProperty: "detail") var main: LinkingObjects<MyList>
    
    convenience init(title: String, memo: String? = nil, date: Date?, tag: String?, priority: String?, complete: Bool) {
        self.init()
        
        self.title = title
        self.memo = memo
        self.date = date
        self.tag = tag
        self.priority = priority
        self.complete = complete
    }
    
}

