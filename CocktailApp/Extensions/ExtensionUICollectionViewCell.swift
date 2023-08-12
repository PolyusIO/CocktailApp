//
//  ExtensionUICollectionViewCell.swift
//  CocktailApp
//
//  Created by Сергей Поляков on 12.08.2023.
//

import UIKit

extension UICollectionViewCell {
    func setupCustomCell() {
        layer.cornerRadius = 5.0
        layer.borderWidth = 0.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 8)
        layer.shadowRadius = 9.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
}
