// MovieTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// ViewController
final class MovieTableViewController: UIViewController {
    // MARK: Private Properties

    private var films: Films?

    // MARK: Private Visual Components

    private var tableView = UITableView()
    private var topRatedButton = UIButton()
    private var popularButton = UIButton()
    private var upcomingButton = UIButton()

    // MARK: Life Cycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        getTopRatedRequest()
        setupTableView()
        setupPopularButton()
        setupTopRatedButton()
        setupUpcomingButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Hello")
    }

    // MARK: Private Methods

    private func setupTopRatedButton() {
        view.addSubview(topRatedButton)
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        topRatedButton.setTitle("Top Rated", for: .normal)
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

    @objc private func changeGenreMovie(button: UIButton) {
        button.backgroundColor = .systemOrange
        switch button.tag {
        case 0: getTopRatedRequest()
        case 1: getPopularRequest()
        case 2: getUpcomingRequest()
        default: break
        }
    }

    private func setupPopularButton() {
        view.addSubview(popularButton)
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        popularButton.setTitle("Popular", for: .normal)
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
        upcomingButton.setTitle("Upcoming", for: .normal)
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
        title = "Top Movies"
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backButtonTitle = ""
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

    private func getTopRatedRequest() {
        popularButton.backgroundColor = .gray
        upcomingButton.backgroundColor = .gray
        title = "Top Movies"
        films = nil
        for page in 1 ... 5 {
            guard let url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU&page=\(page)"
                )
            else { return }

            URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let usageData = data,
                      let usageResponse = response as? HTTPURLResponse else { return }
                print("status code: \(usageResponse.statusCode)")

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let pageMovies = try decoder.decode(Films.self, from: usageData)
                    if self.films?.results != nil {
                        self.films?.results += pageMovies.results
                    } else {
                        self.films = pageMovies
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error")
                }
            }.resume()
        }
    }

    private func getPopularRequest() {
        topRatedButton.backgroundColor = .gray
        upcomingButton.backgroundColor = .gray
        title = "Popular Movies"
        films = nil
        for page in 1 ... 5 {
            guard let url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU&page=\(page)"
                )
            else { return }

            URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let usageData = data,
                      let usageResponse = response as? HTTPURLResponse else { return }
                print("status code: \(usageResponse.statusCode)")

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let pageMovies = try decoder.decode(Films.self, from: usageData)
                    if self.films?.results != nil {
                        self.films?.results += pageMovies.results
                    } else {
                        self.films = pageMovies
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error")
                }
            }.resume()
        }
    }

    private func getUpcomingRequest() {
        topRatedButton.backgroundColor = .gray
        popularButton.backgroundColor = .gray
        title = "Upcoming Movies"
        films = nil
        for page in 1 ... 5 {
            guard let url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU&page=\(page)"
                )
            else { return }

            URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let usageData = data,
                      let usageResponse = response as? HTTPURLResponse else { return }
                print("status code: \(usageResponse.statusCode)")

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let pageMovies = try decoder.decode(Films.self, from: usageData)
                    if self.films?.results != nil {
                        self.films?.results += pageMovies.results
                    } else {
                        self.films = pageMovies
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error")
                }
            }.resume()
        }
    }
}

// MARK: UITableViewDataSource

extension MovieTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countFilms = films?.results.count else { return Int() }
        return countFilms
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmsTableViewCell.identifier,
            for: indexPath
        ) as? FilmsTableViewCell else { return UITableViewCell() }
        cell.configureCell(films: films, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: UITableViewDelegate

extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = films?.results[indexPath.row].id else { return }
        let detailTableViewController = DetailTableViewController()
        detailTableViewController.movieID = id
        navigationController?.pushViewController(detailTableViewController, animated: true)
    }
}
