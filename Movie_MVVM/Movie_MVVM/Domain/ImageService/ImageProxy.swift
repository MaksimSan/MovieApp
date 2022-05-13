// ImageProxy.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class ImageProxy: ImageProxyProtocol {
    
    // MARK: - Private Properties

    private let imageAPIService: ImageAPIServiceProtocol
    private let cacheImageService: CacheImageServiceProtocol

    // MARK: - Initializers

    init(imageAPIService: ImageAPIServiceProtocol, cacheImageService: CacheImageServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.cacheImageService = cacheImageService
    }

    // MARK: - Public Methods

    func loadImage(posterPath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let image = cacheImageService.getImageFromCache(posterPath: posterPath)

        if image == nil {
            imageAPIService.getImage(posterPath: posterPath) { result in
                switch result {
                case let .success(data):
                    guard let image = UIImage(data: data) else { return }
                    self.cacheImageService.saveImageToCache(posterPath: posterPath, image: image)
                    completion(.success(image))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } else {
            guard let image = image else { return }
            completion(.success(image))
        }
    }
}
