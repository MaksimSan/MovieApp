// ImageAPIServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ImageAPIServiceProtocol: AnyObject {
    func getImage(posterPath: String, completion: @escaping (Swift.Result<Data, Error>) -> ())
}
