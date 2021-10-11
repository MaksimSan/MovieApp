// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieViewController: UIViewController {
    // MARK: Enums

    private enum URL {
        static let topRatedCategory =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        static let popularCategory =
            "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        static let upcomingCategory =
            "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
    }

    private enum Constant {
        static let topRatedCategoryTitle = "Top Rated"
        static let popularCategoryTitle = "Popular"
        static let upcomingCategoryTitle = "Upcoming"
    }

    private enum Categories: Int {
        case topRated
        case popular
        case upcoming
    }

    // MARK: Private Properties

    private var viewModel: MovieViewModelProtocol?

    // MARK: Private Visual Components

    private var tableView = UITableView()
    private var topRatedButton = UIButton()
    private var popularButton = UIButton()
    private var upcomingButton = UIButton()

    // MARK: Life Cycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getMovie(url: URL.topRatedCategory)
        setupTableView()
        setupPopularButton()
        setupTopRatedButton()
        setupUpcomingButton()
        reloadTable()
    }

    // MARK: Internal Methods

    func setupViewModel(viewModel: MovieViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: Private Methods

    private func reloadTable() {
        viewModel?.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupTopRatedButton() {
        view.addSubview(topRatedButton)
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        topRatedButton.setTitle(Constant.topRatedCategoryTitle, for: .normal)
        topRatedButton.backgroundColor = .systemOrange
        topRatedButton.layer.cornerRadius = 5
        topRatedButton.layer.borderWidth = 1
        topRatedButton.layer.borderColor = UIColor.black.cgColor
        topRatedButton.tag = 0
        topRatedButton.addTarget(self, action: #selector(changeGenreMovie), for: .touchUpInside)
        NSLayoutConstraint.activate([
            topRatedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            topRatedButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            topRatedButton.trailingAnchor.constraint(equalTo: popularButton.leadingAnchor, constant: -30),
            topRatedButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    private func setupPopularButton() {
        view.addSubview(popularButton)
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        popularButton.setTitle(Constant.popularCategoryTitle, for: .normal)
        popularButton.backgroundColor = .gray
        popularButton.layer.cornerRadius = 5
        popularButton.layer.borderWidth = 1
        popularButton.layer.borderColor = UIColor.black.cgColor
        popularButton.tag = 1
        popularButton.addTarget(self, action: #selector(changeGenreMovie), for: .touchUpInside)
        NSLayoutConstraint.activate([
            popularButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            popularButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            popularButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    private func setupUpcomingButton() {
        view.addSubview(upcomingButton)
        upcomingButton.translatesAutoresizingMaskIntoConstraints = false
        upcomingButton.setTitle(Constant.upcomingCategoryTitle, for: .normal)
        upcomingButton.backgroundColor = .gray
        upcomingButton.layer.cornerRadius = 5
        upcomingButton.layer.borderWidth = 1
        upcomingButton.layer.borderColor = UIColor.black.cgColor
        upcomingButton.addTarget(self, action: #selector(changeGenreMovie), for: .touchUpInside)
        upcomingButton.tag = 2
        NSLayoutConstraint.activate([
            upcomingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            upcomingButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 30),
            upcomingButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            upcomingButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    private func setupTableView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: FilmsTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func changeGenreMovie(button: UIButton) {
        button.backgroundColor = .systemOrange
        switch Categories(rawValue: button.tag) {
        case .topRated:
            viewModel?.getMovie(url: URL.topRatedCategory)
            popularButton.backgroundColor = .gray
            upcomingButton.backgroundColor = .gray
            title = Constant.topRatedCategoryTitle
        case .popular:
            viewModel?.getMovie(url: URL.popularCategory)
            topRatedButton.backgroundColor = .gray
            upcomingButton.backgroundColor = .gray
            title = Constant.popularCategoryTitle
        case .upcoming:
            viewModel?.getMovie(url: URL.upcomingCategory)
            topRatedButton.backgroundColor = .gray
            popularButton.backgroundColor = .gray
            title = Constant.upcomingCategoryTitle
        default: break
        }
    }
}

// MARK: UITableViewDataSource

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countFilms = viewModel?.results?.count else { return Int() }
        return countFilms
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmsTableViewCell.identifier,
            for: indexPath
        ) as? FilmsTableViewCell else { return UITableViewCell() }
        cell.configureCell(
            posterPath: viewModel?.results?[indexPath.row].posterPath,
            title: viewModel?.results?[indexPath.row].title,
            overview: viewModel?.results?[indexPath.row].overview,
            releaseDate: viewModel?.results?[indexPath.row].releaseDate,
            ratingAvarage: viewModel?.results?[indexPath.row].voteAverage
        )
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: UITableViewDelegate

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel?.results?[indexPath.row].id else { return }
        let detailTableViewController = DetailTableViewController()
        detailTableViewController.movieID = id
        navigationController?.pushViewController(detailTableViewController, animated: true)
    }
}
