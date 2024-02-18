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
    
    func createItem(item: TodoRealm) throws {
        do {
            try realm.write{
                realm.add(item)
                print(realm.configuration.fileURL)
            }
        } catch {
            throw RealmError.CreateFail
        }
        
    }
    
    
    func fetchItem(filter: FilterEnum) -> Results<TodoRealm> {
        
        var todoData = realm.objects(TodoRealm.self)
        
        switch filter {
        case .none:
            
            return todoData
        case .complete:
            todoData = todoData.where {
                $0.complete == true
            }
            return todoData
        case .priority:
            todoData = todoData.where {
                $0.priority != nil
            }.sorted(byKeyPath: "priority", ascending: false)
            
            return todoData
        case .date:
            todoData = todoData.where {
                $0.date != nil
            }.sorted(byKeyPath: "date", ascending: true)
            
            return todoData
        }
        
        
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
    
    func realmCount() -> Int {
        return realm.objects(TodoRealm.self).count
    }
}
