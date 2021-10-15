// RepositoryProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(argumentPredicateOne: String, argumentPredicateTwo: String) -> [Entity]?
    func save(object: [Entity])
}
