//
//  TopTabView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 17/02/2022.
//

import UIKit

class TopTabViewModel {
    let title: String
    private(set) var isActive: Bool = false
    private var tabTappedAction: (() -> Void)?

    var updateState: ((_ isActive: Bool) -> Void)?

    init(title: String, isActive: Bool, tabTappedAction: (() -> Void)? = nil) {
        self.title = title
        self.tabTappedAction = tabTappedAction
        self.isActive = isActive
    }

    func tabTapped() {
        tabTappedAction?()
    }

    func updateState(isActive: Bool) {
        updateState?(isActive)
    }
}

class TopTabView: UIView {
    private let viewModel: TopTabViewModel

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.montserratSemiBold(size: 12)
        return label
    }()

    private var bottomView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .latteViolet
        return view
    }()

    init(with viewModel: TopTabViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        self.viewModel.updateState = { [weak self] isActive in
            self?.updateState(isActive: isActive)
        }

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateState(isActive: Bool) {
        bottomView.alpha = isActive ? 1 : 0
    }

    @objc private func tabTapped() {
        viewModel.tabTapped()
    }

    private func setupUI() {
        titleLabel.text = viewModel.title
        isUserInteractionEnabled = true

        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(tabTapped))
        addGestureRecognizer(gesture)
        updateState(isActive: viewModel.isActive)
    }

    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])

        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 8),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
