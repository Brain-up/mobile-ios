//
//  AppTextFieldWithClear.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/24/22.
//

import UIKit

class AppTextFieldWithClear: AppTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let clearButton = UIButton()
        let closeIcon = UIImage(named: "closeIcon")?.withRenderingMode(.alwaysTemplate)
        clearButton.tintColor = .mouseGrey
        clearButton.setImage(closeIcon, for: .normal)
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    @objc private func clear() {
        text?.removeAll()
    }
}
