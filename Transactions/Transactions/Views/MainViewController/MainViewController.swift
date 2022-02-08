//
//  MainViewController.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import UIKit

class MainViewController: UIViewController {

    private let placeholder: PlaceholderView
    private let tableView = UITableView()

    private let viewModel: MainViewControllerViewModel

    init(viewModel: MainViewControllerViewModel) {
        self.viewModel = viewModel
        let placeholderViewModel = PlaceholderViewModel()
        placeholderViewModel.didTapActionButton = {
            viewModel.didTapDownloadButton()
        }
        self.placeholder = PlaceholderView(viewModel: placeholderViewModel)
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

        viewModel.fetchOrders()
        viewModel.ordersDidUpdate = { [weak self] in
            guard let self = self else { return }
            self.update(with: self.viewModel)
            self.placeholder.viewModel.stopActivityIndicator?()
            self.tableView.reloadData()
        }
    }

    private func setupViews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        placeholder.isHidden = true

        tableView.isHidden = true
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = view.backgroundColor
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.reuseIdentifier)
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(placeholder)
    }
    
    private func setupLayout() {
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholder.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            placeholder.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func update(with model: MainViewControllerViewModel) {
        let shouldHidePlaceholder = model.hidePlaceholder
        placeholder.isHidden = shouldHidePlaceholder
        tableView.isHidden = !shouldHidePlaceholder
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfOrders()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OrderCell.reuseIdentifier,
                for: indexPath
            ) as? OrderCell,
            let cellViewModel = viewModel.orderCellViewModel(at: indexPath.row)
        else {
            return UITableViewCell()
        }

        cell.update(with: cellViewModel)
        return cell
    }
}

extension MainViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
}
