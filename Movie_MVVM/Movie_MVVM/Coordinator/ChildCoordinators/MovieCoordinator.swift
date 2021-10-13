// MovieCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieCoordinator: BaseCoordinator {
    var navController: UINavigationController?
    var onFinishFlow: VoidHandler?
    var assemblyModule: AssemblyModuleProtocol

    required init(assemblyModule: AssemblyModuleProtocol, navController: UINavigationController? = nil) {
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

        if navController == nil {
            let navController = UINavigationController(rootViewController: movieVC)
            self.navController = navController
            setAsRoot(navController)
        } else if let navController = navController {
            navController.pushViewController(movieVC, animated: true)
            setAsRoot(navController)
        }
    }

    private func showDetailsModule(movieID: Int) {
        let detailVC = assemblyModule.createDetailsVC(movieID: movieID)
        navController?.pushViewController(detailVC, animated: true)
    }
}
