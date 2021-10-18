// RealmRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

final class RealmRepository<RealmEntity: Object>: DataBaseRepository<RealmEntity> {
    override func get(argumentPredicateOne: String, argumentPredicateTwo: String) -> [RealmEntity]? {
        let predicate = NSPredicate(format: "\(argumentPredicateOne) == %@", argumentPredicateTwo)
        do {
            let realm = try Realm()
            let objects = realm.objects(RealmEntity.self).filter(predicate)
            var entites: [Entity]?
            objects.forEach { movie in
                (entites?.append(movie)) ?? (entites = [movie])
            }
            return entites
        } catch {
            return nil
        }
    }

    override func save(object: [RealmEntity]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    override func delete() {
        do {
            let realm = try Realm()
            try realm.write {
                let realmObject = realm.objects(RealmEntity.self)
                realm.delete(realmObject)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
