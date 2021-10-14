// RepositoryProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(predicate: NSPredicate) -> [Entity]?
    func save(object: [Entity])
    func createPredicate(argumentOne: String, argumentTwo: String) -> NSPredicate
}
