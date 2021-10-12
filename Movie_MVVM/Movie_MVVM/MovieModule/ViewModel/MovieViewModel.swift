// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieViewModelProtocol {
    var results: [Result]? { get set }
    var reloadTable: VoidHandler? { get set }
    var updateTopRatedCategory: VoidHandler? { get set }
    var updatePopularCategory: VoidHandler? { get set }
    var updateUpcomingCategory: VoidHandler? { get set }
    func getMovie(url: String)
    func updateUI(with buttonTag: Int)
}

final class MovieViewModel: MovieViewModelProtocol {


    // MARK: Internal Properties
    let topRatedCategory =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    let popularCategory =
        "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    let upcomingCategory =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    var results: [Result]?
    var reloadTable: VoidHandler?
    var updateTopRatedCategory: VoidHandler?
    var updatePopularCategory: VoidHandler?
    var updateUpcomingCategory: VoidHandler?

    // MARK: Initializers

    init() {
        getMovie(url: topRatedCategory)
    }

    // MARK: Internal Methods

    func updateUI(with buttonTag: Int) {
        switch buttonTag {
        case 0:
            getMovie(url: topRatedCategory)
            updateTopRatedCategory?()
        case 1:
            getMovie(url: popularCategory)
            updatePopularCategory?()
        case 2:
            getMovie(url: upcomingCategory)
            updateUpcomingCategory?()
        default: break
        }
    }

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
