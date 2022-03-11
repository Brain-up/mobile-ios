//
//  AuthVC.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import UIKit

class AuthVC: BasicVC {
    
    private var loginField: UITextField!
    private var passwordField: UITextField!
    private var logoView: UIView!
    var model: AuthVMProtocol?

    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        setupLogoView()
        setupLoginField()
        setupPasswordField()
        setupLoginButton()
        setupRegisterButton()
    }
    
    private func setupLogoView() {
        logoView = LogoView(frame: .zero)
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLoginField() {
        loginField = AppTextFieldWithClear()
        loginField.placeholder = "auth.Username".localized
        view.addSubview(loginField)
        loginField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            loginField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 52)
        ])
    }
    
    private func setupPasswordField() {
        passwordField = AppTextFieldPassword()
        passwordField.placeholder = "auth.Password".localized
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 15),
            passwordField.leftAnchor.constraint(equalTo: loginField.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: loginField.rightAnchor)
        ])
    }
    
    private func setupLoginButton() {
        let loginButton = GradientButton()
        loginButton.setTitle("auth.Login".localized, for: .normal)
        loginButton.update(cornerRadius: 16, insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        
    }
    
    private func setupRegisterButton() {
        let registerButton = WhiteButton()
        registerButton.setTitle("auth.Registration".localized, for: .normal)
        registerButton.update(cornerRadius: 16, insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        registerButton.addTarget(self, action: #selector(onTapRegistration), for: .touchUpInside)
    }
    
    @objc func onTapLogin() {
        model?.auth(login: loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    @objc func onTapRegistration() {
        model?.register(login: loginField.text ?? "", password: passwordField.text ?? "")
    }
}
