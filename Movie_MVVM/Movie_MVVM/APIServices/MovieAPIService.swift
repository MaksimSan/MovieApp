// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ())
}

final class MovieAPIService: MovieAPIServiceProtocol {
    static let topRatedCategoryURL =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    static let popularCategoryURL =
        "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    let upcomingCategoryURL =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    private let detailsFirstPath = "https://api.themoviedb.org/3/movie/"
    private let detailsSecondPath = "?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"

    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ()) {
        guard let url = URL(string: detailsFirstPath + String(movieID ?? 0) + detailsSecondPath) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let details = try decoder.decode(Details.self, from: usageData)
                completion(.success(details))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
