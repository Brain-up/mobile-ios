//
//  LogoView.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/9/22.
//

import UIKit

class LogoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let logoImage = LogoImageView()
        addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 118),
            logoImage.widthAnchor.constraint(equalToConstant: 143)
        ])
        let logoLabel = LogoLabel()
        addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 14),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
