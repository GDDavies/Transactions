//
//  OrderCell.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import UIKit

final class OrderCell: UITableViewCell {

    static let reuseIdentifier = "OrderCell"

    private let verticalStackView = UIStackView()
    private let topHorizontalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let detailTitleLabel = UILabel()
    private let bottomHorizontalStackView = UIStackView()
    private let subtitleLabel = UILabel()
    private let detailSubtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .black
        contentView.backgroundColor = backgroundColor
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4

        titleLabel.textColor = .white
        titleLabel.font = Font.regular(size: 15)

        detailTitleLabel.textColor = .white
        detailTitleLabel.font = Font.regular(size: 15)
        detailTitleLabel.setContentHuggingPriority(.required, for: .horizontal)

        subtitleLabel.textColor = Color.subtitle
        subtitleLabel.font = Font.regular(size: 13)

        detailSubtitleLabel.textColor = Color.subtitle
        detailSubtitleLabel.font = Font.regular(size: 13)
        detailSubtitleLabel.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(topHorizontalStackView)
        topHorizontalStackView.addArrangedSubview(titleLabel)
        topHorizontalStackView.addArrangedSubview(detailTitleLabel)

        verticalStackView.addArrangedSubview(bottomHorizontalStackView)
        bottomHorizontalStackView.addArrangedSubview(subtitleLabel)
        bottomHorizontalStackView.addArrangedSubview(detailSubtitleLabel)
    }

    private func setupLayout() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func update(with viewModel: OrderCellViewModel) {
        titleLabel.text = viewModel.title
        detailTitleLabel.text = viewModel.detailTitle
        subtitleLabel.text = viewModel.subtitle
        detailSubtitleLabel.text = viewModel.detailSubtitle
    }

}
