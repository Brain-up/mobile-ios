//
//  YearCollectionFooterView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 07/03/2022.
//

import UIKit

class YearCollectionFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        backgroundColor = .appWhite
    }
}
