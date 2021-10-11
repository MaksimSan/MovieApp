// Films.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Films
struct Films: Decodable {
    let page: Int
    var results: [Result]
    let totalResults: Int
    let totalPages: Int
}

/// Result
struct Result: Decodable {
    var posterPath: String?
    let overview: String
    let title: String
    let releaseDate: String
    let id: Int
    let voteAverage: Float
}
