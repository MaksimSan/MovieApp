// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    var assemblyModule: AssemblyModuleProtocol
    var navController: UINavigationController?

    required init(assemblyModule: AssemblyModuleProtocol, navController: UINavigationController? = nil) {
        self.assemblyModule = assemblyModule
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
