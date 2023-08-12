//
//  Model.swift
//  CocktailApp
//
//  Created by Сергей Поляков on 11.08.2023.
//


//MARK: - Link enum
enum Link: String {
    case ingredientsForPickerView = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
    case drinksByIngredient = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
    case drink = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
    case image = "https://www.thecocktaildb.com/images/ingredients/"
}


//MARK: - Model for displaying the drink
struct Drinks: Decodable {
    let drinks: [Drink]
}

struct Drink: Decodable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkAlternate: String?
    let strTags: String?
    let strVideo: String?
    let strCategory: String?
    let strIba: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strImageSource: String?
    
    
    var name: String {
        strDrink ?? ""
    }
    
    var image: String {
        strDrinkThumb ?? ""
    }
    
    var ingredients: [DrinkIngredient] {
        let strIngredient = [
            strIngredient1, strIngredient2, strIngredient3,
            strIngredient4, strIngredient5, strIngredient6,
            strIngredient7, strIngredient8, strIngredient9,
            strIngredient10, strIngredient11, strIngredient12,
            strIngredient13, strIngredient14, strIngredient15
        ]
        let strMeasure = [
            strMeasure1, strMeasure2, strMeasure3,
            strMeasure4, strMeasure5, strMeasure6,
            strMeasure7, strMeasure8, strMeasure9,
            strMeasure10, strMeasure11, strMeasure12,
            strMeasure13, strMeasure14, strMeasure15
        ]
        var result: [DrinkIngredient] = []
        
        for (name, measure) in zip(strIngredient, strMeasure) {
            if let name = name, let measure = measure, !name.isEmpty, !measure.isEmpty {
                result.append(DrinkIngredient(name: name, measure: measure))
            } else {
                return result
            }
        }
        return result
    }
}

struct DrinkIngredient {
    let name: String
    let measure: String
    var imageUrl: String {
        Link.image.rawValue + name.replacingOccurrences(of: " ", with: "%20") + "-Medium.png"
    }
}



//MARK: - Model for display in PickerView
struct Ingredients: Decodable {
    let drinks: [Ingredient]
}

struct Ingredient: Decodable {
    let strIngredient1: String
    
    var drinksUrl: String {
        Link.drinksByIngredient.rawValue + strIngredient1.replacingOccurrences(of: " ", with: "%20")
    }
}



//MARK: - Model for display drinks by ingredient
struct DrinksByIngredient: Decodable {
    let drinks: [DrinkByIngredient]
}

struct DrinkByIngredient: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
