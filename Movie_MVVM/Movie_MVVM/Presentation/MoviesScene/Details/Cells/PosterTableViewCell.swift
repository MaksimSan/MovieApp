// PosterTableViewCell.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    
    // MARK: Static Properties

    static let identifier = "PosterTableViewCell"

    // MARK: Private Properties

    private let posterImageView = UIImageView()
    private let imageService = ImageService()
    private let placeholderImage = "film"

    // MARK: Life cycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupImageView()
    }

    // MARK: Public Methods

    func configureCell(posterPath: String) {
        imageService.getImage(posterPath: posterPath) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(image):
                    self.posterImageView.image = image
                case .failure:
                    self.posterImageView.image = UIImage(systemName: self.placeholderImage)
                }
            }
        }
    }

    // MARK: Private Methods

    private func setupImageView() {
        addSubview(posterImageView)
        posterImageView.tintColor = .gray
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
