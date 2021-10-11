// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieViewModelProtocol {
    var results: [Result]? { get set }
    var reloadTable: VoidHandler? { get set }
    func getMovie(url: String)
}

final class MovieViewModel: MovieViewModelProtocol {
    // MARK: Enums

    static let topRatedCategory =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    static let popularCategory =
        "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    static let upcomingCategory =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"

    // MARK: Internal Properties

    var results: [Result]?
    var reloadTable: VoidHandler?

    // MARK: Internal Methods

    func getMovie(url: String) {
        results = nil
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieList = try decoder.decode(Film.self, from: usageData)
                self.results = movieList.results
                DispatchQueue.main.async {
                    self.reloadTable?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
