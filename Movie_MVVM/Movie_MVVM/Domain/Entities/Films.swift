// Films.swift
// Copyright © ClickWatch. All rights reserved.

import Foundation
import RealmSwift

struct Films: Decodable {
    var results: [FilmObject]
}

final class FilmObject: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var overview = String()
    @objc dynamic var title = String()
    @objc dynamic var releaseDate = String()
    @objc dynamic var id = Int()
    @objc dynamic var voteAverage = Float()
    @objc dynamic var category: String?
}
