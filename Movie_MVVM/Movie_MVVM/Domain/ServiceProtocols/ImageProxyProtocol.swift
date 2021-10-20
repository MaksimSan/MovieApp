// ImageProxyProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ImageProxyProtocol {
    func loadImage(posterPath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}
