// Films.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фильм
struct Film: Decodable {
    var results: [Result]
}

final class Result: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var overview = String()
    @objc dynamic var title = String()
    @objc dynamic var releaseDate = String()
    @objc dynamic var id = Int()
    @objc dynamic var voteAverage = Float()
    @objc dynamic var category: String?
}
