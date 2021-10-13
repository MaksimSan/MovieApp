// DetailsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var updateProps: DetailsHandler? { get set }
    var reloadTable: VoidHandler? { get set }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: Enums

    private enum Constants {
        static let errorTitle = "Не удалось загрузить данные"
        static let errorMessage = "Ошибка: "
    }

    // MARK: Internal Properties

    var movieID: Int?
    var reloadTable: VoidHandler?
    var updateProps: DetailsHandler?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol, movieID: Int?) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
        getDetailsMovie()
        updateProps?(.loading)
    }

    // MARK: Private Methods

    private func getDetailsMovie() {
        movieAPIService.getMovieDetails(movieID: movieID) { [weak self] result in
            switch result {
            case let .success(details):
                DispatchQueue.main.async {
                    self?.updateProps?(.success([details]))
                    self?.reloadTable?()
                }
            case let .failure(error):
                self?
                    .updateProps?(.failure(
                        Constants.errorTitle,
                        Constants.errorMessage + "\(error.localizedDescription)"
                    ))
            }
        }
    }
}
