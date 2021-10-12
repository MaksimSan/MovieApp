// DetailsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var details: Details? { get set }
    var reloadTable: VoidHandler? { get set }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: Internal Properties

    var movieID: Int?
    var reloadTable: VoidHandler?
    var details: Details?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol, movieID: Int?) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
        getDetailsMovie()
    }

    // MARK: Private Methods

    private func getDetailsMovie() {
        movieAPIService.getMovieDetails(movieID: movieID) { [weak self] result in
            switch result {
            case let .success(details):
                self?.details = details
                DispatchQueue.main.async {
                    self?.reloadTable?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
