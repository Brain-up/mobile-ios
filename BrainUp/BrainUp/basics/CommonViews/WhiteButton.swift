//
//  WhiteButton.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/9/22.
//

import Foundation

import UIKit

class WhiteButton: UIButton {

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
        backgroundColor = .appWhite
        setTitleColor(.darkViolet, for: .normal)
        titleLabel?.font = UIFont.montserratSemiBold(size: 12)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.borderWidth = 1.0
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor.buttonBorder.cgColor
        contentEdgeInsets = insets

        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 16
    }
}
