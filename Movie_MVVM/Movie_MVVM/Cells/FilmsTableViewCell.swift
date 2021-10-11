// FilmsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// FilmsTableViewCell
final class FilmsTableViewCell: UITableViewCell {
    // MARK: Static Properties

    static let identifier = "FilmsTableViewCell"

    // MARK: Private Visual Components

    private let mainView = UIView()
    private let titleLabel = UILabel()
    private let posterImageView = UIImageView()
    private let overviewLabel = UILabel()
    private let realiseDatelabel = UILabel()
    private let ratingAvarage = UILabel()

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

    func configureCell(films: Films?, indexPath: IndexPath) {
        guard let usageFilms = films else { return }
        DispatchQueue.global().async {
            guard let posterPath = usageFilms.results[indexPath.row].posterPath,
                  let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"),
                  let imageData = try? Data(contentsOf: url),
                  let posterImage = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = posterImage
            }
        }
        titleLabel.text = usageFilms.results[indexPath.row].title
        overviewLabel.text = usageFilms.results[indexPath.row].overview
        realiseDatelabel.text = convertDateFormat(inputDate: usageFilms.results[indexPath.row].releaseDate)
        ratingAvarage.text = String(usageFilms.results[indexPath.row].voteAverage)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

    // MARK: Private Methods

    private func convertDateFormat(inputDate: String) -> String {
        let oldDateFormatter = DateFormatter()
        oldDateFormatter.dateFormat = "yyyy-MM-dd"

        guard let oldDate = oldDateFormatter.date(from: inputDate) else { return String() }

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM yyyy"
        convertDateFormatter.locale = NSLocale(localeIdentifier: "ru_RU_POSIX") as Locale

        return convertDateFormatter.string(from: oldDate)
    }

    private func setupAvarage() {
        mainView.addSubview(ratingAvarage)
        ratingAvarage.translatesAutoresizingMaskIntoConstraints = false
        ratingAvarage.backgroundColor = .gray
        ratingAvarage.textAlignment = .center
        ratingAvarage.clipsToBounds = true
        ratingAvarage.layer.cornerRadius = 5
        ratingAvarage.layer.borderWidth = 2
        ratingAvarage.textColor = .white
        ratingAvarage.layer.borderColor = UIColor.yellow.cgColor
        NSLayoutConstraint.activate([
            ratingAvarage.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            ratingAvarage.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 5),
            ratingAvarage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5),
            ratingAvarage.widthAnchor.constraint(
                equalTo: ratingAvarage.heightAnchor,
                multiplier: 1.5
            )
        ])
    }

    private func setupRealiseDateLabel() {
        mainView.addSubview(realiseDatelabel)
        realiseDatelabel.translatesAutoresizingMaskIntoConstraints = false
        realiseDatelabel.textAlignment = .right
        realiseDatelabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            realiseDatelabel.heightAnchor.constraint(equalToConstant: 25),
            realiseDatelabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            realiseDatelabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            realiseDatelabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
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
            overviewLabel.bottomAnchor.constraint(equalTo: realiseDatelabel.topAnchor, constant: -5),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5)
        ])
    }

    private func setupPosterImageView() {
        mainView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleToFill
        if posterImageView.image == nil {
            posterImageView.tintColor = .gray
            posterImageView.image = UIImage(systemName: "film")
        }
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7)
        ])
    }
}
