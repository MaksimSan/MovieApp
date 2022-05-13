// ImageService.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class ImageService: ImageServiceProtocol {
    func getImage(posterPath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageAPIService = ImageAPIService()
        let cacheImageService = CacheImageService()
        let proxy = ImageProxy(imageAPIService: imageAPIService, cacheImageService: cacheImageService)
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
