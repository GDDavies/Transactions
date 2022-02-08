//
//  PlaceholderView.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import UIKit

final class PlaceholderView: UIView {
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = UIButton()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: actionButton.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor)
        ])
        return indicator
    }()
    
    private let viewModel: PlaceholderViewModel

    init(viewModel: PlaceholderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupHierarchy()
        setupLayout()
        update(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.axis = .vertical
        stackView.alignment = .center

        titleLabel.textColor = .white
        titleLabel.font = Font.semiBold(size: 24)

        subtitleLabel.textColor = Color.subtitle
        subtitleLabel.font = Font.regular(size: 16)

        actionButton.backgroundColor = Color.brand
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.setTitle("", for: .disabled)
        actionButton.titleLabel?.font = Font.semiBold(size: 16)
        actionButton.layer.cornerRadius = 4
        actionButton.addSubview(activityIndicator)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(actionButton)
    }
    
    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            actionButton.heightAnchor.constraint(equalToConstant: 56),
            actionButton.widthAnchor.constraint(equalToConstant: 213)
        ])
        
        stackView.setCustomSpacing(34, after: imageView)
        stackView.setCustomSpacing(12, after: titleLabel)
        stackView.setCustomSpacing(40, after: subtitleLabel)
    }
    
    private func update(with model: PlaceholderViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)

        viewModel.startActivityIndicator = { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.actionButton.isEnabled = false
        }

        viewModel.stopActivityIndicator = { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.actionButton.isEnabled = true
        }
    }

    @objc
    private func didTapActionButton() {
        viewModel.didTapActionButton?()
        viewModel.startActivityIndicator?()
    }
}
