//
//  CocktailsViewController.swift
//  CocktailApp
//
//  Created by Сергей Поляков on 11.08.2023.
//

import UIKit

final class CocktailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ingredientPickerView: UIPickerView!
    
    
    //MARK: - Private properties
    private let reuseIdentifier = "cocktail"
    private var ingredients: Ingredients?
    private var drinksByIngredient: DrinksByIngredient?

    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        ingredientPickerView.delegate = self
        ingredientPickerView.dataSource = self
        fetchIngredientsForPickerView(from: Link.ingredientsForPickerView.rawValue)
    }
    
    //MARK: - Private func
    private func fetchIngredientsForPickerView(from url: String) {
        NetworkManager.shared.fetch(dataType: Ingredients.self, from: url) { [weak self] result in
            switch result{
            case .success(let ingredients):
                self?.ingredients = ingredients
                self?.fetchDrinksByIngredient(from: ingredients.drinks.first?.drinksUrl ?? "")
                self?.ingredientPickerView.reloadAllComponents()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchDrinksByIngredient(from url: String) {
        NetworkManager.shared.fetch(dataType: DrinksByIngredient.self, from: url) { [weak self] result in
            switch result{
            case .success(let drinks):
                self?.drinksByIngredient = drinks
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        guard let detailedVC = segue.destination as? DetailedViewController else { return }
        detailedVC.idDrink = drinksByIngredient?.drinks[indexPath.item].idDrink
    }
}


// MARK: - UICollectionViewDataSource
extension CocktailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinksByIngredient?.drinks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cocktail", for: indexPath) as? CocktailCell else { return UICollectionViewCell() }
        
        cell.configure(with: drinksByIngredient?.drinks[indexPath.item])
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
extension CocktailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: 150, height: collectionView.bounds.height - 50) }
}


// MARK: - UIPickerViewDelegate
extension CocktailsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ingredients?.drinks[row].strIngredient1 ?? "load data..."
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let url = ingredients?.drinks[row].drinksUrl ?? ""
        fetchDrinksByIngredient(from: url)
    }
}

// MARK: - UIPickerViewDataSource
extension CocktailsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ingredients?.drinks.count ?? 1
    }
}
