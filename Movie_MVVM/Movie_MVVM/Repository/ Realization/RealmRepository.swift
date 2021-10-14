// RealmRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

final class RealmRepository<RealmEntity: Object>: DataBaseRepository<RealmEntity> {
    override func get(predicate: NSPredicate) -> [RealmEntity]? {
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

    override func createPredicate(argumentOne: String, argumentTwo: String) -> NSPredicate {
        NSPredicate(format: "\(argumentOne) == %@", argumentTwo)
    }
}
