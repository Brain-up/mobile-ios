//
//  AppTextField.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/22/22.
//

import UIKit

class AppTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    
    override var placeholder: String? {
        willSet {
            attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.mouseGrey]
            )
        }
    }
    
    private var border: UIView = {
        let border = UIView()
        border.backgroundColor = .latterGrey
        border.isUserInteractionEnabled = false
        return border
    }()
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    func setup() {
        addSubview(border)
        font = UIFont.openSansRegular(size: 14)
        textColor = .almostBlack
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
    }
}
