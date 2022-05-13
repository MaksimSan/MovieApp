// MovieViewModel.swift
// Copyright © ClickWatch. All rights reserved.

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
        static let topRatedCategoryURLPath: String = "top_rated"
        static let popularCategoryURLPath: String = "popular"
        static let upcomingCategoryURLPath: String = "upcoming"
        static let errorTitle: String = "Не удалось загрузить данные"
        static let errorMessage: String = "Ошибка: "
        static let categoryTitle: String = "category"
        static let topRatedButtonTag: Int = 0
        static let popularButtonTag: Int = 1
        static let upcomingButtonTag: Int = 2
    }

    // MARK: Public Properties

    var reloadTable: VoidHandler?
    var updateProps: ResultHandler?
    var didTap: StringHandler?

    // MARK: Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: DataBaseRepository<FilmObject>
    private var results: [FilmObject]?

    // MARK: Initializers

    init(movieAPIService: MovieAPIServiceProtocol, repository: DataBaseRepository<FilmObject>) {
        self.movieAPIService = movieAPIService
        self.repository = repository
        repository.delete()
        updateProps?(.loading)
        getMovies(urlPath: Constants.topRatedCategoryURLPath)
    }

    // MARK: Public Methods

    func updateData(with buttonTag: Int) {
        switch buttonTag {
        case Constants.topRatedButtonTag:
            getMovies(urlPath: Constants.topRatedCategoryURLPath)
            didTap?(Constants.topRatedCategoryURLPath)
        case Constants.popularButtonTag:
            getMovies(urlPath: Constants.popularCategoryURLPath)
            didTap?(Constants.popularCategoryURLPath)
        case Constants.upcomingButtonTag:
            getMovies(urlPath: Constants.upcomingCategoryURLPath)
            didTap?(Constants.upcomingCategoryURLPath)
        default:
            break
        }
    }

    // MARK: Private Methods

    private func getMovies(urlPath: String) {
        results = nil
        results = repository.get(argumentPredicateOne: Constants.categoryTitle, argumentPredicateTwo: urlPath)

        if results == nil {
            movieAPIService.getMovieList(urlPath: urlPath) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    result.forEach { $0.category = urlPath }
                    DispatchQueue.main.async {
                        self.repository.save(object: result)
                        self.results = self.repository.get(
                            argumentPredicateOne: Constants.categoryTitle,
                            argumentPredicateTwo: urlPath
                        )
                        self.updateProps?(.success(self.results))
                        self.reloadTable?()
                    }

                case let .failure(error):
                    DispatchQueue.main.async {
                        self.updateProps?(.failure(Constants.errorTitle,
                                                   Constants.errorMessage + "\(error.localizedDescription)"))
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.updateProps?(.success(self.results))
                self.reloadTable?()
            }
        }
    }
}
