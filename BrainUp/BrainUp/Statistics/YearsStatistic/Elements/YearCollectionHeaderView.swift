//
//  YearCollectionHeaderView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 07/03/2022.
//

import UIKit

class YearCollectionHeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .charcoalGrey
        label.textAlignment = .center
        return label
    }()

    func configure(with title: String, fontSize: CGFloat) {
        titleLabel.text = title
        titleLabel.font = UIFont.montserratSemiBold(size: fontSize)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        backgroundColor = .appWhite
        setupLabel()
    }

    private func setupLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
