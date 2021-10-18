// DataBaseRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Абстракция над репозиторием
class DataBaseRepository<DataBaseEntity>: RepositoryProtocol {
    func get(argumentPredicateOne: String, argumentPredicateTwo: String) -> [DataBaseEntity]? {
        fatalError("Override required")
    }

    func save(object: [DataBaseEntity]) {
        fatalError("Override required")
    }

    func delete() {
        fatalError("Override required")
    }
}
