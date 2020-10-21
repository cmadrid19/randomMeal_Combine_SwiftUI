//
//  MealData.swift
//  RandomMealCombine
//
//  Created by Maxim Macari on 21/10/2020.
//

import SwiftUI

struct MealData: Decodable{
    let meals:[Meal]
}

struct Meal: Decodable {
    let name: String
    let imageUrlString: String
    let ingredients: [Ingredient]
    let instructions: String
}

extension Meal{
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)
        
        var index = 1
        var ingredients: [Ingredient] = []
        
        while let ingredient = mealDictionary["strIngredient\(index)"] as? String,
              let measure = mealDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        self.ingredients = ingredients
        name = mealDictionary["strMeal"] as? String ?? ""
        imageUrlString = mealDictionary["strMealThumb"] as? String ?? ""
        instructions = mealDictionary["strInstructions"] as? String ?? ""
    }
    
}

struct Ingredient: Decodable, Hashable{
    
    let name: String
    let measure: String
    
    
}
