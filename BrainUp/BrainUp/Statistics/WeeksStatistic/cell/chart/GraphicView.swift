//
//  GraphicView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 20/02/2022.
//

import UIKit

class GraphicView: UIView {
    private let stackView = UIStackView()
    private let viewModel: GraphicViewModelProtocol

    init(with viewModel: GraphicViewModelProtocol) {
        self.viewModel = viewModel

        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
    }

    private func setupConstraints() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        viewModel.items.forEach { stackView.addArrangedSubview(ColumnView(with: $0)) }
    }

}
