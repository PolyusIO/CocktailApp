//
//  DetailedViewController.swift
//  CocktailApp
//
//  Created by Сергей Поляков on 11.08.2023.
//

import UIKit

final class DetailedViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .darkGray
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Private properties
    private let reuseIdentifier = "cell"
    private let width = (UIScreen.main.bounds.width - 16 - 16 - 10 - 10) / 3
    private var drink: Drink?
    private var ingredient: [drinkIngredient] = []
    
    // MARK: - Public propertie
    public var idDrink: String?
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchDrink(from: "\(Link.drink.rawValue)\(idDrink ?? "11007")")
    }
    
    //MARK: - Private func
    private func fetchDrink(from url: String) {
        NetworkManager.shared.fetch(dataType: Drinks.self, from: url) { [weak self] result in
            switch result {
            case .success(let drinkAsArray):
                let drink = drinkAsArray.drinks.first
                self?.drink = drink
                self?.fetchImage(from: drink?.image ?? "")
                self?.descriptionLabel.text = drink?.strInstructions
                self?.titleLabel.text = drink?.name
                self?.ingredient = drink?.ingredients ?? []
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    private func fetchImage(from url: String) {
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageDate):
                self?.imageView.image = UIImage(data: imageDate)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// MARK: - Collection view data source
extension DetailedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredient.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? IngredientCell else { return UICollectionViewCell() }
        
        cell.configure(with: ingredient[indexPath.row])
        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 8)
        cell.layer.shadowRadius = 9.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        
        return cell
    }
}

// MARK: - Collection view delegate flow layout
extension DetailedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: width, height: collectionView.bounds.height - 50) }
}
