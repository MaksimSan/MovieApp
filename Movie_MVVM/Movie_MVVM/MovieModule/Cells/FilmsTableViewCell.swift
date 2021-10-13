// FilmsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FilmsTableViewCell: UITableViewCell {
    // MARK: Enums

    private enum Constant {
        static let currentDateFormat = "yyyy-MM-dd"
        static let convertDateFormat = "dd MMM yyyy"
        static let localeIdentifier = "ru_RU_POSIX"
        static let placeholderPosterImage = "film"
    }

    // MARK: Static Properties

    static let identifier = "FilmsTableViewCell"

    // MARK: Private Visual Components

    private let mainView = UIView()
    private let titleLabel = UILabel()
    private let posterImageView = UIImageView()
    private let overviewLabel = UILabel()
    private let realiseDateLabel = UILabel()
    private let ratingAvarageLabel = UILabel()

    // MARK: Private Properties

    private let imageAPIService = ImageAPIService()

    // MARK: Set Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        setupPosterImageView()
        setupTitleLabel()
        setupRealiseDateLabel()
        setupOverviewLabel()
        setupAvarage()
    }

    // MARK: Internal Properties

    func configureCell(
        posterPath: String?,
        title: String?,
        overview: String?,
        releaseDate: String?,
        ratingAvarage: Float?
    ) {
        imageAPIService.getImage(posterPath: posterPath ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(imageData):
                    self?.posterImageView.image = UIImage(data: imageData)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
        titleLabel.text = title
        overviewLabel.text = overview
        realiseDateLabel.text = convertDateFormat(inputDate: releaseDate ?? "")
        ratingAvarageLabel.text = String(ratingAvarage ?? 0)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

    // MARK: Private Methods

    private func convertDateFormat(inputDate: String) -> String {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = Constant.currentDateFormat

        guard let currentDate = currentDateFormatter.date(from: inputDate) else { return String() }

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = Constant.convertDateFormat
        convertDateFormatter.locale = NSLocale(localeIdentifier: Constant.localeIdentifier) as Locale

        return convertDateFormatter.string(from: currentDate)
    }

    private func setupAvarage() {
        mainView.addSubview(ratingAvarageLabel)
        ratingAvarageLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingAvarageLabel.backgroundColor = .gray
        ratingAvarageLabel.textAlignment = .center
        ratingAvarageLabel.clipsToBounds = true
        ratingAvarageLabel.layer.cornerRadius = 5
        ratingAvarageLabel.layer.borderWidth = 2
        ratingAvarageLabel.textColor = .white
        ratingAvarageLabel.layer.borderColor = UIColor.yellow.cgColor
        NSLayoutConstraint.activate([
            ratingAvarageLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            ratingAvarageLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 5),
            ratingAvarageLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5),
            ratingAvarageLabel.widthAnchor.constraint(
                equalTo: ratingAvarageLabel.heightAnchor,
                multiplier: 1.5
            )
        ])
    }

    private func setupRealiseDateLabel() {
        mainView.addSubview(realiseDateLabel)
        realiseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        realiseDateLabel.textAlignment = .right
        realiseDateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            realiseDateLabel.heightAnchor.constraint(equalToConstant: 25),
            realiseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            realiseDateLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            realiseDateLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
        ])
    }

    private func setupView() {
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mainView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainView.heightAnchor.constraint(equalToConstant: 200)
        ])
        mainView.layer.cornerRadius = 10
        mainView.contentMode = .scaleAspectFill
        mainView.layer.borderColor = UIColor.systemOrange.cgColor
        mainView.layer.borderWidth = 1
        mainView.clipsToBounds = true
    }

    private func setupTitleLabel() {
        mainView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
        ])
    }

    private func setupOverviewLabel() {
        mainView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.textAlignment = .center
        overviewLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overviewLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            overviewLabel.bottomAnchor.constraint(equalTo: realiseDateLabel.topAnchor, constant: -5),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5)
        ])
    }

    private func setupPosterImageView() {
        mainView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleToFill
        if posterImageView.image == nil {
            posterImageView.tintColor = .gray
            posterImageView.image = UIImage(systemName: Constant.placeholderPosterImage)
        }
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7)
        ])
    }
}
