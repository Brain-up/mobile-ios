//
//  LogoImageView.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/24/22.
//

import UIKit

class LogoImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        image = UIImage(named: "logo")
        contentMode = .scaleAspectFit
    }
}
