// DetailsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class DetailTableViewController: UITableViewController {
    // MARK: Enums

    private enum Cells {
        case poster
        case title
        case overview
    }

    // MARK: Private Properties

    private let activityIndicator = UIActivityIndicatorView()
    private let cells: [Cells] = [.poster, .title, .overview]
    private let identifires = [
        PosterTableViewCell.identifier,
        TitleTableViewCell.identifier,
        OverviewTableViewCell.identifier
    ]
    private var viewModel: DetailsViewModelProtocol?
    private var dataProps: DataProps<Details> = .loading {
        didSet {
            view.setNeedsLayout()
        }
    }

    // MARK: Life Cycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadTable()
        updateProps()
        setupActivityIndicator()
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

    func setupViewModel(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: Private Methods

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    private func updateProps() {
        viewModel?.updateProps = { [weak self] props in
            self?.dataProps = props
        }
    }

    private func reloadTable() {
        viewModel?.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
    }

    // MARK: Override Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .success(details) = dataProps,
              let details = details?.first else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: identifires[indexPath.row], for: indexPath)
        switch cells[indexPath.row] {
        case .poster:
            guard let posterCell = cell as? PosterTableViewCell else { return UITableViewCell() }
            posterCell.configureCell(posterPath: details.posterPath)
        case .title:
            guard let titleCell = cell as? TitleTableViewCell else { return UITableViewCell() }
            titleCell.configureCell(title: details.title)
        case .overview:
            guard let overviewCell = cell as? OverviewTableViewCell else { return UITableViewCell() }
            overviewCell.configureCell(overview: details.overview)
        }
        return cell
    }
}
