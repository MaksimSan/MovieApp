// Details.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

final class Details: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var title = String()
    @objc dynamic var overview = String()
    @objc dynamic var movieID: String?
}
