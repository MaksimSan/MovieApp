// TitleTableViewCell.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

final class TitleTableViewCell: UITableViewCell {
    
    // MARK: Static Properties

    static let identifier = "TitleTableViewCell"

    // MARK: Private Properties

    private let titleMovie = UILabel()
    private let titleIdentifier = "Title Details"

    // MARK: Life cycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupTitleLabel()
    }

    // MARK: Public Methods

    func configureCell(title: String) {
        titleMovie.text = title
    }

    // MARK: Private Methods

    private func setupTitleLabel() {
        addSubview(titleMovie)
        titleMovie.accessibilityIdentifier = titleIdentifier
        titleMovie.textAlignment = .center
        titleMovie.font = UIFont.boldSystemFont(ofSize: 18)
        titleMovie.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleMovie.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            titleMovie.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            titleMovie.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            titleMovie.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            titleMovie.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
