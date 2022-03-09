//
//  AuthVC.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import UIKit

class AuthVC: UIViewController {
    
    var loginField: UITextField!
    var passwordField: UITextField!

    override func loadView() {
        super.loadView()
        let logoImage = LogoImageView()
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 118),
            logoImage.widthAnchor.constraint(equalToConstant: 143)
        ])
        let logoLabel = LogoLabel()
        view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 14),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loginField = AppTextFieldWithClear()
        loginField.placeholder = "Login"
        view.addSubview(loginField)
        loginField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            loginField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 52)
        ])
        
        passwordField = AppTextFieldPassword()
        passwordField.placeholder = "Password"
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 15),
            passwordField.leftAnchor.constraint(equalTo: loginField.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: loginField.rightAnchor)
        ])
        
        let loginButton = GradientButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.update(cornerRadius: 16, insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        // Do any additional setup after loading the view.
    }

}
