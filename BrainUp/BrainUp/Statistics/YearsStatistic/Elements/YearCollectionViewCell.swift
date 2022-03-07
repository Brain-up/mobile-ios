//
//  YearCollectionViewCell.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 07/03/2022.
//

import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
    }
}
