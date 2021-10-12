// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieViewModelProtocol: AnyObject {
    var results: [Result]? { get set }
    var reloadTable: VoidHandler? { get set }
    var updateProps: PropsHandler? { get set }
    var updateCategory: StringHandler? { get set }
    func updateUI(with buttonTag: Int)
}

final class MovieViewModel: MovieViewModelProtocol {
    // MARK: Enums

    private enum Constants {
        static let topRatedCategoryTitle = "top_rated"
        static let popularCategoryTitle = "popular"
        static let upcomingCategoryTitle = "upcoming"
        static let errorTitle = "Не удалось загрузить данные"
        static let errorMessage = "Ошибка: "
    }

    // MARK: Internal Properties

    var results: [Result]?
    var reloadTable: VoidHandler?
    var updateProps: PropsHandler?
    var updateCategory: StringHandler?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
        updateProps?(.initial)
        getMovies(urlPath: Constants.topRatedCategoryTitle)
    }

    // MARK: Internal Methods

    func updateUI(with buttonTag: Int) {
        switch buttonTag {
        case 0:
            getMovies(urlPath: Constants.topRatedCategoryTitle)
            updateCategory?(Constants.topRatedCategoryTitle)
        case 1:
            getMovies(urlPath: Constants.popularCategoryTitle)
            updateCategory?(Constants.popularCategoryTitle)
        case 2:
            getMovies(urlPath: Constants.upcomingCategoryTitle)
            updateCategory?(Constants.upcomingCategoryTitle)
        default: break
        }
    }

    // MARK: Private Methods

    private func getMovies(urlPath: String) {
        movieAPIService.getMovieList(urlPath: urlPath) { [weak self] result in
            switch result {
            case let .success(result):
                DispatchQueue.main.async {
                    self?.updateProps?(.success(result))
                    self?.reloadTable?()
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self?
                        .updateProps?(.failure(
                            Constants.errorTitle,
                            Constants.errorMessage + "\(error.localizedDescription)"
                        ))
                }
            }
        }
    }
}
