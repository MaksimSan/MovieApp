// RealmRepositoryTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie_MVVM
import RealmSwift
import XCTest

final class MockModel: Object {
    @objc dynamic var name = "Foo"
    @objc dynamic var surname = "Baz"
}

final class RealmRepositoryTest: XCTestCase {
    var realmRepository: RealmRepository<MockModel>!

    override func setUpWithError() throws {
        realmRepository = RealmRepository()
    }

    override func tearDownWithError() throws {
        realmRepository = nil
    }

    func testRealmRepository() {
        let object = [MockModel()]
        realmRepository.save(object: object)
        let catchObject = realmRepository.get(argumentPredicateOne: "name", argumentPredicateTwo: "Foo")
        realmRepository.delete()
        XCTAssertNotNil(catchObject)
    }
}
