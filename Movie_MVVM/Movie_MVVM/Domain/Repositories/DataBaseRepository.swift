// DataBaseRepository.swift
// Copyright © ClickWatch. All rights reserved.

import Foundation

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(argumentPredicateOne: String, argumentPredicateTwo: String) -> [Entity]?
    func save(object: [Entity])
    func delete()
}

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
