//
//  GradientButton.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 17/02/2022.
//

import UIKit

class GradientButton: UIButton {

    private var cornerRadius: CGFloat = 16
    private var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    func update(cornerRadius: CGFloat, insets: UIEdgeInsets) {
        self.cornerRadius = cornerRadius
        self.insets = insets
    }

    private func setupUI() {
        setTitleColor(.white, for: [.normal, .highlighted, .selected, .disabled])
        titleLabel?.font = UIFont.montserratSemiBold(size: 12)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        layer.borderWidth = 1.0
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor.coldViolet.cgColor
        contentEdgeInsets = insets

        backgroundColor = UIColor.clear

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.coldViolet.cgColor, UIColor.warmViolet.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = cornerRadius
        
        backgroundColor = UIColor.clear
        
        backgroundColor = UIColor.clear

        // replace gradient as needed
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }

        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 16
    }
}
