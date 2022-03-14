//
//  BasicVC.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/9/22.
//

import UIKit

protocol BasicViewInterface: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(errorMessage: String?)
    func hideError()
}

class BasicVC: UIViewController {
    private var loader: UIActivityIndicatorView?

}

extension BasicVC: BasicViewInterface {
    func showLoading() {
        if loader == nil {
            loader = UIActivityIndicatorView(style: .large)
            loader?.center = view.center
            loader?.color = .black
            view.addSubview(loader ?? UIView())
        }
        DispatchQueue.main.async {[weak self] in
            self?.loader?.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {[weak self] in
            self?.loader?.stopAnimating()
        }
    }
    
    func showError(errorMessage: String?) {
        let alert = UIAlertController(title: "basic.error".localized, message: errorMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "basic.cancel".localized, style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    func hideError() {

    }
}
