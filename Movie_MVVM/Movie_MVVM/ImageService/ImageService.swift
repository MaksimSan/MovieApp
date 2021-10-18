// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ImageServiceProtocol {
    func getImage(posterPath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ())
}

final class ImageService: ImageServiceProtocol {
    func getImage(posterPath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        let imageAPIService = ImageAPIService()
        let cacheImageService = CacheImageService()
        let proxy = Proxy(imageAPIService: imageAPIService, cacheImageService: cacheImageService)
        proxy.loadImage(posterPath: posterPath) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
