// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol ImageAPIServiceProtocol: AnyObject {
    func getImage(posterPath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    private let imageURL = "https://image.tmdb.org/t/p/w500"

    func getImage(posterPath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        DispatchQueue.global().async {
            guard let url = URL(string: self.imageURL + posterPath),
                  let imageData = try? Data(contentsOf: url),
                  let posterImage = UIImage(data: imageData)
            else {
                let error = NSError(domain: "", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            DispatchQueue.main.async {
                completion(.success(posterImage))
            }
        }
    }
}
