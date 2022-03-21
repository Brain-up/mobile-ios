//
//  LogoLabel.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/24/22.
//

import UIKit

class LogoLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        text = "BrainUp"
        font = UIFont.reenieBeanie(size: 40)
        textColor = .charcoalGrey
    }
}
