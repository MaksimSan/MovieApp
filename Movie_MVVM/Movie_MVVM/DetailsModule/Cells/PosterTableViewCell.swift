// PosterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    // MARK: Static Properties

    static let identifier = "PosterTableViewCell"

    // MARK: Private Visual Components

    private let posterImageView = UIImageView()

    // MARK: Private Properties

    private let imageAPIService = ImageAPIService()

    // MARK: Set Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupImageView()
    }

    // MARK: Internal Methods

    func configureCell(posterPath: String) {
        imageAPIService.getImage(posterPath: posterPath) { [weak self] result in
            switch result {
            case let .success(image):
                self?.posterImageView.image = image
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: Private Methods

    private func setupImageView() {
        addSubview(posterImageView)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            posterImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            posterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
