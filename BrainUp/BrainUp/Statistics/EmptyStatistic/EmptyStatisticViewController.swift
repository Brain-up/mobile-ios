//
//  EmptyStatisticViewController.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

final class EmptyStatisticViewController: UIViewController {
    private let imageView: UIImageView
    private let messageLabel = UILabel()
    private let stackView = UIStackView()
    private let startExercisesButton = GradientButton()

    private var viewModel: EmptyStatisticViewModelProtocol

    init(viewModel: EmptyStatisticViewModelProtocol) {
        self.viewModel = viewModel
        imageView = UIImageView(image: viewModel.image)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite

        setupConstraints()
        setupUI()
    }

    private func setupUI() {
        messageLabel.font = UIFont.montserratRegular(size: 10)
        messageLabel.textColor = .activeGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = viewModel.message

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        stackView.distribution = .equalSpacing

        startExercisesButton.setTitle(viewModel.buttonTitle, for: .normal)
        startExercisesButton.addTarget(self, action: #selector(startExercisesButtonClicked), for: .touchUpInside)
    }

    @objc func startExercisesButtonClicked() {
        viewModel.startExercisesButtonAction?()
    }

    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
            stackView.heightAnchor.constraint(equalToConstant: 160)
        ])

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(messageLabel)

        view.addSubview(startExercisesButton)
        startExercisesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startExercisesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startExercisesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            startExercisesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
