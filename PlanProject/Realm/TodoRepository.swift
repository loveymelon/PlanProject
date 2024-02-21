//
//  TodoRepository.swift
//  PlanProject
//
//  Created by 김진수 on 2/17/24.
//

import Foundation
import RealmSwift
import Toast

enum RealmError: Error {
    case CreateFail
    case UpdateFail(text: String)
    case DeleteFail
}

final class TodoRepository {
    private let realm = try! Realm()
    
    func createItem<T: Object>(item: T) throws {
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL)
            }
        } catch {
            throw RealmError.CreateFail
        }
        
    }
    
    func fetchCategoryItem(categoryItem: CategoryEnum) -> Results<TodoRealm> {
        var todoData = realm.objects(TodoRealm.self)
        
        switch categoryItem {
        case .today:
            let start = Calendar.current.startOfDay(for: Date())
            
            let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
            
            let predicate = NSPredicate(format: "date >= %@ && date < %@", start as NSDate, end as NSDate)
            
            todoData = todoData.filter(predicate)
        case .plan:
            let start = Calendar.current.startOfDay(for: Date())
            
            let predicate = NSPredicate(format: "date > %@", start as NSDate)
            
            todoData = todoData.filter(predicate)
        case .all:
            break
        case .flag:
            break
        case .complete:
            todoData = todoData.where {
                $0.complete == true
            }
        }
        
        return todoData
    }
    
    func fetchFilterItem(filter: FilterEnum) -> Results<TodoRealm> {
        
        var todoData = realm.objects(TodoRealm.self)
        
        switch filter {
        case .none:
            break
            
        case .complete:
            todoData = todoData.where {
                $0.complete == true
            }
            
        case .priority:
            todoData = todoData.where {
                $0.priority != nil
            }.sorted(byKeyPath: "priority", ascending: false)
            
        case .date:
            todoData = todoData.where {
                $0.date != nil
            }.sorted(byKeyPath: "date", ascending: true)
            
        }
        
        return todoData
        
    }
    
    func fetchDateItem(filter: Date) -> Results<TodoRealm> {
        
        var todoData = realm.objects(TodoRealm.self)
        
        let start = Calendar.current.startOfDay(for: filter)
        
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        let predicate = NSPredicate(format: "date >= %@ && date < %@", start as NSDate, end as NSDate)
        
        todoData = todoData.filter(predicate)
        
        return todoData
        
    }
    
    // 만약 기존 값이랑 다르다면 업데이트
    func updateItem(index: Int, updateData: TodoEnum, text: String = "", complete: Bool = false) throws {
        
        var todoData = realm.objects(TodoRealm.self)
        
        switch updateData {
        case .complete:
            do {
                try realm.write {
                    print(complete)
                    todoData[index].complete = complete
                }
            } catch {
                throw RealmError.UpdateFail(text: "complete")
            }
        case .title:
            do {
                try realm.write {
                    todoData[index].title = text
                }
            } catch {
                throw RealmError.UpdateFail(text: "title")
            }
        case .memo:
            do {
                try realm.write {
                    todoData[index].memo = text
                }
            } catch {
                throw RealmError.UpdateFail(text: "memo")
            }
        }
        
    }
    
    func deleteItem(index: Int) throws {
        
        var todoData = realm.objects(TodoRealm.self)
        
        do {
            try realm.write {
                realm.delete(todoData[index])
            }
        } catch {
            throw RealmError.DeleteFail
        }
        
    }
    
    func realmCount(category: CategoryEnum) -> Int {
        var todoData = realm.objects(TodoRealm.self)
        switch category {
        case .today:
            let start = Calendar.current.startOfDay(for: Date())
            
            let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date() // 이게 타입 추론이 안되는 이유가 기억이 안난다...
            
            let predicate = NSPredicate(format: "date >= %@ && date < %@", start as NSDate, end as NSDate)
            
            todoData = todoData.filter(predicate)
        case .plan:
            let start = Calendar.current.startOfDay(for: Date())
            
            let predicate = NSPredicate(format: "date > %@", start as NSDate)
            
            todoData = todoData.filter(predicate)
        case .all:
            break
        case .flag:
            break
        case .complete:
            todoData = todoData.where {
                $0.complete == true
            }
        }
        
        return todoData.count
    }
    
    func fetchRealmObject() -> Results<MyList> {
        return realm.objects(MyList.self)
    }
    
    func updateMyListDetail(myListItem: MyList?, detail: TodoRealm) {
        
        do {
            try realm.write {
                myListItem?.detail.append(detail)
            }
        } catch {
            
        }
    }
    
    
}
