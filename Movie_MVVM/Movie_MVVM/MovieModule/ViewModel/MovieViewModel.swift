// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieViewModelProtocol: AnyObject {
    var reloadTable: VoidHandler? { get set }
    var updateProps: ResultHandler? { get set }
    var didTap: StringHandler? { get set }
    func updateData(with buttonTag: Int)
}

final class MovieViewModel: MovieViewModelProtocol {
    // MARK: Enums

    private enum Constants {
        static let topRatedCategoryURLPath = "top_rated"
        static let popularCategoryURLPath = "popular"
        static let upcomingCategoryURLPath = "upcoming"
        static let errorTitle = "Не удалось загрузить данные"
        static let errorMessage = "Ошибка: "
    }

    // MARK: Internal Properties

    var reloadTable: VoidHandler?
    var updateProps: ResultHandler?
    var didTap: StringHandler?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
        updateProps?(.loading)
        getMovies(urlPath: Constants.topRatedCategoryURLPath)
    }

    // MARK: Internal Methods

    func updateData(with buttonTag: Int) {
        switch buttonTag {
        case 0:
            getMovies(urlPath: Constants.topRatedCategoryURLPath)
            didTap?(Constants.topRatedCategoryURLPath)
        case 1:
            getMovies(urlPath: Constants.popularCategoryURLPath)
            didTap?(Constants.popularCategoryURLPath)
        case 2:
            getMovies(urlPath: Constants.upcomingCategoryURLPath)
            didTap?(Constants.upcomingCategoryURLPath)
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
