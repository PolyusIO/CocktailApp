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
    
    var ingredients: [drinkIngredient] {
        
        var result: [drinkIngredient] = []
        
        func addIngredient(name: String?, measure: String?) {
            if let name = name, let measure = measure, name != "", measure != "" {
                result.append(drinkIngredient(name: name, measure: measure))
            }
        }
        
        addIngredient(name: strIngredient1, measure: strMeasure1)
        addIngredient(name: strIngredient2, measure: strMeasure2)
        addIngredient(name: strIngredient3, measure: strMeasure3)
        addIngredient(name: strIngredient4, measure: strMeasure4)
        addIngredient(name: strIngredient5, measure: strMeasure5)
        addIngredient(name: strIngredient6, measure: strMeasure6)
        addIngredient(name: strIngredient7, measure: strMeasure7)
        addIngredient(name: strIngredient8, measure: strMeasure8)
        addIngredient(name: strIngredient9, measure: strMeasure9)
        addIngredient(name: strIngredient10, measure: strMeasure10)
        addIngredient(name: strIngredient11, measure: strMeasure11)
        addIngredient(name: strIngredient12, measure: strMeasure12)
        addIngredient(name: strIngredient13, measure: strMeasure13)
        addIngredient(name: strIngredient14, measure: strMeasure14)
        addIngredient(name: strIngredient15, measure: strMeasure15)
        
        return result
    }
}

struct drinkIngredient {
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
