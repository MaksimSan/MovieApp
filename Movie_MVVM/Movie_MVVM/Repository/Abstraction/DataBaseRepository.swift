// DataBaseRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Абстракция над репозиторием
class DataBaseRepository<DataBaseEntity>: RepositoryProtocol {
    func get(predicate: NSPredicate) -> [DataBaseEntity]? {
        fatalError("Override required")
    }

    func save(object: [DataBaseEntity]) {
        fatalError("Override required")
    }

    func createPredicate(argumentOne: String, argumentTwo: String) -> NSPredicate {
        fatalError("Override required")
    }
}
