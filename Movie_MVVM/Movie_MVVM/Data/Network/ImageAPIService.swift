// ImageAPIService.swift
// Copyright © ClickWatch. All rights reserved.

import Foundation

final class ImageAPIService: ImageAPIServiceProtocol {
    private let imageURL = "https://image.tmdb.org/t/p/w500"

    func getImage(posterPath: String, completion: @escaping (Swift.Result<Data, Error>) -> ()) {
        DispatchQueue.global().async {
            do {
                guard let url = URL(string: self.imageURL + posterPath) else { return }
                let imageData = try Data(contentsOf: url)
                completion(.success(imageData))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
