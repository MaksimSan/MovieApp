// AssemblyModule.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

protocol AssemblyModuleProtocol {
    func createMovieVC() -> UIViewController
    func createDetailsVC(movieID: Int?) -> UIViewController
}

final class AssemblyModule: AssemblyModuleProtocol {
    func createMovieVC() -> UIViewController {
        let movieAPIService = MovieAPIService()
        let movieViewModel = MovieViewModel(movieAPIService: movieAPIService, repository: RealmRepository<FilmObject>())
        let movieViewController = MovieViewController()
        movieViewController.setupViewModel(viewModel: movieViewModel)
        return movieViewController
    }

    func createDetailsVC(movieID: Int?) -> UIViewController {
        let detailsTableViewController = DetailsTableViewController()
        let movieAPIService = MovieAPIService()
        let detailsViewModel = DetailsViewModel(
            movieAPIService: movieAPIService,
            movieID: movieID,
            repository: RealmRepository<Details>()
        )
        detailsTableViewController.setupViewModel(viewModel: detailsViewModel)
        return detailsTableViewController
    }
}
