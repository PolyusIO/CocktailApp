//
//  CustomShadowCell.swift
//  CocktailApp
//
//  Created by Сергей Поляков on 12.08.2023.
//

import UIKit

class CustomShadowCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 0.0
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 5, height: 8)
        contentView.layer.shadowRadius = 9.0
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.masksToBounds = false
    }

    required init?(coder: NSCoder) {
       super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
}
