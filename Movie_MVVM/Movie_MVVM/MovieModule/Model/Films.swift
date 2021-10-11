// Films.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Перечисление, содержащее модели для списка фильмов и их состояний
enum MovieData {
    case topRated([Result])
    case popular([Result])
    case upcoming([Result])

    struct Film: Decodable {
        var results: [Result]
    }

    struct Result: Decodable {
        let posterPath: String
        let overview: String
        let title: String
        let releaseDate: String?
        let id: Int?
        let voteAverage: Float?
    }
}
