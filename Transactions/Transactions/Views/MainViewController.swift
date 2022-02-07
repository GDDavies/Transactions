//
//  MainViewController.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import UIKit

class MainViewController: UIViewController {
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.black
    }
}

