// MovieCoordinator.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class MovieCoordinator: BaseCoordinator {
    var onFinishFlow: VoidHandler?
    private var navController: UINavigationController
    private var assemblyModule: AssemblyModuleProtocol

    required init(assemblyModule: AssemblyModuleProtocol, navController: UINavigationController) {
        self.assemblyModule = assemblyModule
        self.navController = navController
        super.init(assemblyModule: assemblyModule, navController: navController)
    }

    override func start() {
        showMovieModule()
    }

    private func showMovieModule() {
        guard let movieVC = assemblyModule.createMovieVC() as? MovieViewController else { return }

        movieVC.toDetails = { [weak self] movieID in
            self?.showDetailsModule(movieID: movieID)
        }

        navController.pushViewController(movieVC, animated: true)
        setAsRoot(navController)
    }

    private func showDetailsModule(movieID: Int) {
        let detailVC = assemblyModule.createDetailsVC(movieID: movieID)
        navController.pushViewController(detailVC, animated: true)
    }
}
