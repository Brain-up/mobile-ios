//
//  BrainUpTabBarItemViewController.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 17/02/2022.
//

import UIKit

final class TabBarItemViewController: UIViewController {
    private let stackView = UIStackView()
    let containerView = UIView()

    private var viewModel: TabBarItemViewModelProtocol

    init(viewModel: TabBarItemViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkViolet

        setupUI()
        setupConstraints()

        let rightBarButtonItems: [UIBarButtonItem] = viewModel.rightBarButtons.enumerated().map { (index, image) in
            let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonClicked))
            item.tag = index
            return item
        }
        
        navigationItem.rightBarButtonItems = rightBarButtonItems
    }

    func update(with viewModel: TabBarItemViewModelProtocol) {
        self.viewModel = viewModel
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
            viewModel.topTabViews.forEach {
                self?.stackView.addArrangedSubview($0)
            }
            self?.view.layoutSubviews()
        }
        animator.startAnimation()
    }

    @objc private func rightBarButtonClicked(_ sender: UIBarButtonItem) {
        viewModel.rightBarbuttonAction?(sender.tag)
    }

    private func setupUI() {
        navigationItem.title = viewModel.title.uppercased()

        containerView.backgroundColor = .appWhite
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 24
        containerView.clipsToBounds = true

        stackView.axis = .horizontal

        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .fillEqually
    }

    private func setupConstraints() {
        view.addSubview(containerView)
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14)
        ])

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
}
