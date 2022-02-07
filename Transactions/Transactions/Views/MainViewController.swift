//
//  MainViewController.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let placeholder = PlaceholderView()
    
    private let viewModel: MainViewControllerViewModel
        
    init(viewModel: MainViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupViews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
    }
    
    private func setupHierarchy() {
        view.addSubview(placeholder)
    }
    
    private func setupLayout() {
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholder.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            placeholder.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension MainViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
}
