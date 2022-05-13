// ImageServiceProtocol.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

protocol ImageServiceProtocol {
    func getImage(posterPath: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
