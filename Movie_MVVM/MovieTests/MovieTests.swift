// MovieTests.swift
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

final class MovieTests: XCTestCase {
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

    func testCoordinator() {
        appCoordinator.start()
        let movieVC = navController.presentedVC
        XCTAssertTrue(movieVC is MovieViewController)
    }
}