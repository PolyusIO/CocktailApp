//
//  CocktailCell.swift
//  CocktailApp
//
//  Created by Сергей Поляков on 11.08.2023.
//

import UIKit

final class CocktailCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cocktailImageView: UIImageView! {
        didSet {
            cocktailImageView.layer.cornerRadius = 5
            cocktailImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var cocktailNameLabel: UILabel! {
        didSet {
            cocktailNameLabel.textColor = .gray
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public methods
    func configure(with drink: DrinkByIngredient?) {
        cocktailNameLabel.text = drink?.strDrink
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage(from: drink?.strDrinkThumb ?? "")
        setupCustomCell()
    }
    
    // MARK: - Private methods
    private func fetchImage(from url: String) {
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageDate):
                self?.cocktailImageView.image = UIImage(data: imageDate)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
