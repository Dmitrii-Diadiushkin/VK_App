//
//  RealmManager.swift
//  VK_App_SB
//
//  Created by Dmitrii Diadiushkin on 28.08.2020.
//  Copyright © 2020 Dmitrii Diadiushkin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init?() {
        let configuration = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: configuration) else { return nil }
        self.realm = realm
        
        print("Realm database file path:")
        print(realm.configuration.fileURL ?? "")
    }
    
    private let realm: Realm
    
    func addObject<T: Object>(_ data: [T]) {
        do {
            realm.beginWrite()
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
   func add<T: Object>(objects: [T]) throws {
        try realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func getObjects<T: Object>() -> Results<T> {
        return realm.objects(T.self)
    }
    
    func delete<T: Object>(object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
    
}
