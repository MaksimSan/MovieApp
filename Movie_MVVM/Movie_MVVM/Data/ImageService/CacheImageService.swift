// CacheImageService.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class CacheImageService: CacheImageServiceProtocol {
    // MARK: - Private Properties

    private let folderName = "image"
    private let fileManager = FileManager.default
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private var images: [String: UIImage] = [:]

    // MARK: - Internal Methods

    func saveImageToCache(posterPath: String, image: UIImage) {
        guard let fileName = getImagePath(posterPath: posterPath),
              let data = image.pngData() else { return }
        fileManager.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    func getImageFromCache(posterPath: String) -> UIImage? {
        if let image = images[posterPath] {
            return image
        } else {
            guard let filePath = getImagePath(posterPath: posterPath),
                  let image = UIImage(contentsOfFile: filePath) else { return nil }
            images[posterPath] = image
            return image
        }
    }

    // MARK: - Private Methods

    private func getImagePath(posterPath: String) -> String? {
        let folderName = folderName
        guard let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent(folderName, isDirectory: true)
        if !fileManager.fileExists(atPath: url.path) {
            try? fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url.appendingPathComponent(posterPath).path
    }
}
