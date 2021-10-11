// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

typealias MovieDataHandler = (([MovieData]) -> ())

protocol MovieViewModelProtocol {
    var results: [MovieData.Result]? { get set }
    var movieData: MovieDataHandler? { get set }
    var reloadTable: VoidHandler? { get set }
    func getMovie(url: String)
}

final class MovieViewModel: MovieViewModelProtocol {
    // MARK: Internal Properties

    var results: [MovieData.Result]?
    var reloadTable: VoidHandler?
    var movieData: MovieDataHandler?

    // MARK: Internal Methods

    func getMovie(url: String) {
        results = nil
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieList = try decoder.decode(MovieData.Film.self, from: usageData)
//                self.movieData?()
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
