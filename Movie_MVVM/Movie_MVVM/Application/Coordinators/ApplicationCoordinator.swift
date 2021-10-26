// ApplicationCoordinator.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    private var assemblyModule: AssemblyModuleProtocol
    private var navController: UINavigationController

    required init(assemblyModule: AssemblyModuleProtocol, navController: UINavigationController) {
        self.assemblyModule = assemblyModule
        self.navController = navController
        super.init(assemblyModule: assemblyModule, navController: navController)
    }

    override func start() {
        toMovie()
    }

    private func toMovie() {
        let movieCoordinator = MovieCoordinator(assemblyModule: assemblyModule, navController: navController)

        movieCoordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(movieCoordinator)
            self?.start()
        }

        addDependency(movieCoordinator)
        movieCoordinator.start()
    }
}
