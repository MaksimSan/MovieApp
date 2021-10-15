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
        static let movieIDTitle = "movieID"
        static let errorTitle = "Не удалось загрузить данные"
        static let errorMessage = "Ошибка: "
    }

    // MARK: Internal Properties

    var movieID: Int?
    var reloadTable: VoidHandler?
    var updateProps: DetailsHandler?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: DataBaseRepository<Details>
    private var details: Details?

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol, movieID: Int?, repository: DataBaseRepository<Details>) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
        self.repository = repository
        updateProps?(.loading)
        getDetailsMovie()
    }

    // MARK: Private Methods

    private func getDetailsMovie() {
        details = repository.get(
            argumentPredicateOne: Constants.movieIDTitle,
            argumentPredicateTwo: String(movieID ?? 0)
        )?.first
        if details == nil {
            movieAPIService.getMovieDetails(movieID: movieID) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(detail):
                    detail.movieID = String(self.movieID ?? 0)
                    DispatchQueue.main.async {
                        self.repository.save(object: [detail])
                        self.details = self.repository.get(
                            argumentPredicateOne: Constants.movieIDTitle,
                            argumentPredicateTwo: String(self.movieID ?? 0)
                        )?.first
                        guard let details = self.details else { return }
                        self.updateProps?(.success([details]))
                        self.reloadTable?()
                    }
                case let .failure(error):
                    self
                        .updateProps?(.failure(
                            Constants.errorTitle,
                            Constants.errorMessage + "\(error.localizedDescription)"
                        ))
                }
            }
        } else {
            DispatchQueue.main.async {
                guard let details = self.details else { return }
                self.updateProps?(.success([details]))
                self.reloadTable?()
            }
        }
    }
}
