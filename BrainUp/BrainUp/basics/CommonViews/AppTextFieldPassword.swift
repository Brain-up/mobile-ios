//
//  AppTExtFieldPassword.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/24/22.
//

import UIKit

class AppTextFieldPassword: AppTextField {
    private var secureButton: UIButton!
    private var secureIcon = UIImage(named: "eyeClosedIcon")?.withRenderingMode(.alwaysTemplate)
    private var secureOffIcon = UIImage(named: "eyeOpenedIcon")?.withRenderingMode(.alwaysTemplate)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        isSecureTextEntry = true
        secureButton = UIButton()
        secureButton.tintColor = .mouseGrey
        secureButton.addTarget(self, action: #selector(updateSecureState), for: .touchUpInside)
        updateIcon()
        rightView = secureButton
        rightViewMode = .whileEditing
    }
    
    @objc private func updateSecureState() {
        isSecureTextEntry.toggle()
        updateIcon()
    }
    
    private func updateIcon() {
        let newImage = isSecureTextEntry ? secureIcon : secureOffIcon
        secureButton.setImage(newImage, for: .normal)
    }
}
