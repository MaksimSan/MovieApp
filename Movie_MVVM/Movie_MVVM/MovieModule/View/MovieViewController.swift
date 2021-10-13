// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieViewController: UIViewController {
    // MARK: Enums

    private enum Constants {
        static let topRatedCategoryTitle = "Top Rated"
        static let popularCategoryTitle = "Popular"
        static let upcomingCategoryTitle = "Upcoming"
        static let topRatedCategoryURLPath = "top_rated"
        static let popularCategoryURLPath = "popular"
        static let upcomingCategoryURLPath = "upcoming"
    }

    // MARK: Private Visual Components

    private let tableView = UITableView()
    private let topRatedButton = UIButton()
    private let popularButton = UIButton()
    private let upcomingButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()

    // MARK: Private Properties

    private var viewModel: MovieViewModelProtocol?
    private var dataProps: DataProps<Result> = .loading {
        didSet {
            view.layoutIfNeeded()
        }
    }

    // MARK: Life Cycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupNavigationBar()
        setupTableView()
        setupPopularButton()
        setupTopRatedButton()
        setupUpcomingButton()
        reloadTable()
        updateCategory()
        updateProps()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch dataProps {
        case .loading:
            tableView.isHidden = true
            activityIndicator.startAnimating()
        case .success:
            tableView.isHidden = false
            activityIndicator.stopAnimating()
        case let .failure(errorTitle, errorMessage):
            showAlert(title: errorTitle, message: errorMessage, actionTitle: "OK")
        }
    }

    // MARK: Internal Methods

    func setupViewModel(viewModel: MovieViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: Private Methods

    private func updateCategory() {
        viewModel?.updateCategory = { [weak self] categoryTitle in
            switch categoryTitle {
            case Constants.topRatedCategoryURLPath:
                self?.popularButton.backgroundColor = .gray
                self?.upcomingButton.backgroundColor = .gray
                self?.title = Constants.topRatedCategoryTitle
                self?.returnStartTable()
            case Constants.popularCategoryURLPath:
                self?.topRatedButton.backgroundColor = .gray
                self?.upcomingButton.backgroundColor = .gray
                self?.title = Constants.popularCategoryTitle
                self?.returnStartTable()
            case Constants.upcomingCategoryURLPath:
                self?.topRatedButton.backgroundColor = .gray
                self?.popularButton.backgroundColor = .gray
                self?.title = Constants.upcomingCategoryTitle
                self?.returnStartTable()
            default: break
            }
        }
    }

    private func updateProps() {
        viewModel?.updateProps = { [weak self] dataProps in
            self?.dataProps = dataProps
        }
    }

    private func reloadTable() {
        viewModel?.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupTopRatedButton() {
        view.addSubview(topRatedButton)
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        topRatedButton.setTitle(Constants.topRatedCategoryTitle, for: .normal)
        topRatedButton.backgroundColor = .systemOrange
        topRatedButton.layer.cornerRadius = 5
        topRatedButton.layer.borderWidth = 1
        topRatedButton.layer.borderColor = UIColor.black.cgColor
        topRatedButton.tag = 0
        topRatedButton.addTarget(self, action: #selector(changeCategoryMovie), for: .touchUpInside)
        NSLayoutConstraint.activate([
            topRatedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            topRatedButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            topRatedButton.trailingAnchor.constraint(equalTo: popularButton.leadingAnchor, constant: -20),
            topRatedButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupPopularButton() {
        view.addSubview(popularButton)
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        popularButton.setTitle(Constants.popularCategoryTitle, for: .normal)
        popularButton.backgroundColor = .gray
        popularButton.layer.cornerRadius = 5
        popularButton.layer.borderWidth = 1
        popularButton.layer.borderColor = UIColor.black.cgColor
        popularButton.tag = 1
        popularButton.addTarget(self, action: #selector(changeCategoryMovie), for: .touchUpInside)
        NSLayoutConstraint.activate([
            popularButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            popularButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            popularButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupUpcomingButton() {
        view.addSubview(upcomingButton)
        upcomingButton.translatesAutoresizingMaskIntoConstraints = false
        upcomingButton.setTitle(Constants.upcomingCategoryTitle, for: .normal)
        upcomingButton.backgroundColor = .gray
        upcomingButton.layer.cornerRadius = 5
        upcomingButton.layer.borderWidth = 1
        upcomingButton.layer.borderColor = UIColor.black.cgColor
        upcomingButton.addTarget(self, action: #selector(changeCategoryMovie), for: .touchUpInside)
        upcomingButton.tag = 2
        NSLayoutConstraint.activate([
            upcomingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            upcomingButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 20),
            upcomingButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            upcomingButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    private func setupNavigationBar() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupTableView() {
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

    private func returnStartTable() {
        tableView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    @objc private func changeCategoryMovie(button: UIButton) {
        button.backgroundColor = .systemOrange
        viewModel?.updateUI(with: button.tag)
    }
}

// MARK: UITableViewDataSource

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case let .success(result) = dataProps {
            guard let countFilms = result?.count else { return Int() }
            return countFilms
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmsTableViewCell.identifier,
            for: indexPath
        ) as? FilmsTableViewCell else { return UITableViewCell() }
        if case let .success(result) = dataProps {
            cell.configureCell(
                posterPath: result?[indexPath.row].posterPath,
                title: result?[indexPath.row].title,
                overview: result?[indexPath.row].overview,
                releaseDate: result?[indexPath.row].releaseDate,
                ratingAvarage: result?[indexPath.row].voteAverage
            )
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: UITableViewDelegate

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let .success(result) = dataProps {
            guard let id = result?[indexPath.row].id else { return }
            let detailsTableViewController = DetailTableViewController()
            let movieAPIService = MovieAPIService()
            let detailsViewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: id)
            detailsTableViewController.setupViewModel(viewModel: detailsViewModel)
            navigationController?.pushViewController(detailsTableViewController, animated: true)
        }
    }
}
