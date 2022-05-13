// ImageAPIServiceProtocol.swift
// Copyright © ClickWatch. All rights reserved.

import Foundation

protocol ImageAPIServiceProtocol: AnyObject {
    func getImage(posterPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
