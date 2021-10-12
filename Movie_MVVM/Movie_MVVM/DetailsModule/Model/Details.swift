// Details.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
///Подробное описание конкретное фильма
struct Details: Decodable {
    let posterPath: String
    let title: String
    let overview: String
}
