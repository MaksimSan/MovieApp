// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    var topRatedCategoryURL: String { get }
    var popularCategoryURL: String { get }
    var upcomingCategoryURL: String { get }
    func getMovieList(url: String, completion: @escaping (Swift.Result<[Result], Error>) -> ())
    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ())
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: Internal Properties

    let topRatedCategoryURL =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    let popularCategoryURL =
        "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    let upcomingCategoryURL =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"

    // MARK: Private Proeprties

    private let detailsFirstPath = "https://api.themoviedb.org/3/movie/"
    private let detailsSecondPath = "?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    // MARK: Internal Methods

    func getMovieList(url: String, completion: @escaping (Swift.Result<[Result], Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let movieList = try self.decoder.decode(Film.self, from: usageData)
                completion(.success(movieList.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ()) {
        guard let url = URL(string: detailsFirstPath + String(movieID ?? 0) + detailsSecondPath) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let details = try self.decoder.decode(Details.self, from: usageData)
                completion(.success(details))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
