// CoordinatorTest.swift
// Copyright © RoadMap. All rights reserved.

//
//  MovieTests.swift
//  MovieTests
//
//  Created by Maksim on 13.10.2021.
//
@testable import Movie_MVVM
import UIKit
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class CoordinatorTest: XCTestCase {
    var appCoordinator: ApplicationCoordinator!
    var navController: MockNavigationController!
    var assembly: AssemblyModuleProtocol!

    override func setUpWithError() throws {
        navController = MockNavigationController()
        assembly = AssemblyModule()
        appCoordinator = ApplicationCoordinator(assemblyModule: assembly, navController: navController)
    }

    override func tearDownWithError() throws {
        navController = nil
        assembly = nil
        appCoordinator = nil
    }

    func testPresentedMovieVC() {
        appCoordinator.start()
        let movieVC = navController.presentedVC
        XCTAssertTrue(movieVC is MovieViewController)
    }

    func testPresentedDetailsVC() {
        appCoordinator.start()
        guard let movieVC = navController.presentedVC as? MovieViewController else { return }
        movieVC.toDetails?(Int())
        let detailsVC = navController.presentedVC
        XCTAssertTrue(detailsVC is DetailsTableViewController)
    }
}
