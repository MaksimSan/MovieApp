// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let movieViewModel = MovieViewModel()
        let movieViewController = MovieViewController()
        movieViewController.setupViewModel(viewModel: movieViewModel)
        let navController = UINavigationController(rootViewController: movieViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
