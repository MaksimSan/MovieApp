// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ImageServiceProtocol {
    func getImage(posterPath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ())
}
