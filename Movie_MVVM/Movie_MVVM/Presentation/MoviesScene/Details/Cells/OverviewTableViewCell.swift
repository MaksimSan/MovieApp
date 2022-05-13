// OverviewTableViewCell.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class OverviewTableViewCell: UITableViewCell {
    
    // MARK: Static Properties

    static let identifier = "OverviewTableViewCell"

    // MARK: Private Properties

    private let overviewLabel = UILabel()

    // MARK: Life cycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupOverviewLabel()
    }

    // MARK: Public Methods

    func configureCell(overview: String) {
        overviewLabel.text = overview
    }

    // MARK: Private Methods

    private func setupOverviewLabel() {
        addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = .zero
        overviewLabel.textAlignment = .center
        overviewLabel.sizeToFit()
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            overviewLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            overviewLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)

        ])
    }
}
