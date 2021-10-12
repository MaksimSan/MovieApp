// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieViewModelProtocol: AnyObject {
    var results: [Result]? { get set }
    var reloadTable: VoidHandler? { get set }
    var updateTopRatedCategory: VoidHandler? { get set }
    var updatePopularCategory: VoidHandler? { get set }
    var updateUpcomingCategory: VoidHandler? { get set }
    func updateUI(with buttonTag: Int)
}

final class MovieViewModel: MovieViewModelProtocol {
    // MARK: Internal Properties

    var results: [Result]?
    var reloadTable: VoidHandler?
    var updateTopRatedCategory: VoidHandler?
    var updatePopularCategory: VoidHandler?
    var updateUpcomingCategory: VoidHandler?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
        getMovies(url: movieAPIService.topRatedCategoryURL)
    }

    // MARK: Internal Methods

    func updateUI(with buttonTag: Int) {
        switch buttonTag {
        case 0:
            getMovies(url: movieAPIService.topRatedCategoryURL)
            updateTopRatedCategory?()
        case 1:
            getMovies(url: movieAPIService.popularCategoryURL)
            updatePopularCategory?()
        case 2:
            getMovies(url: movieAPIService.upcomingCategoryURL)
            updateUpcomingCategory?()
        default: break
        }
    }

    // MARK: Private Methods

    private func getMovies(url: String) {
        movieAPIService.getMovieList(url: url) { [weak self] result in
            switch result {
            case let .success(result):
                self?.results = result
                DispatchQueue.main.async {
                    self?.reloadTable?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
