// Films.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Модель фильмов
struct Film: Decodable {
    var results: [Result]
}

// Модель результат  полученного фильма
struct Result: Decodable {
    let posterPath: String
    let overview: String
    let title: String
    let releaseDate: String?
    let id: Int?
    let voteAverage: Float?
}
