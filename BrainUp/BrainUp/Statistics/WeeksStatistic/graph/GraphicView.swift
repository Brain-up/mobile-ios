//
//  GraphicView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 20/02/2022.
//

import UIKit
protocol GraphicViewModelProtocol {
    var items: [ColumnView] { get }
}
struct GraphicViewModel: GraphicViewModelProtocol {
    // items creation mock
    let items: [ColumnView] = {
        [UIColor.red, UIColor.blue, UIColor.gray, UIColor.yellow, UIColor.black, UIColor.brown, UIColor.purple].map { item in
            let viewM = ColumnViewModel(columnHeight: CGFloat.random(in: 10.0...60.0), columnColor: item, timeColor: item, time: ["00:00", "150:00", "1000:00"].randomElement()!)
            return ColumnView(with: viewM)
        }
    }()
}
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
        stackView.spacing = 8
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
        viewModel.items.forEach { stackView.addArrangedSubview($0) }
    }

}
