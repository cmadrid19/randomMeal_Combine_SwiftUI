//
//  MealGenerator.swift
//  RandomMealCombine
//
//  Created by Maxim Macari on 21/10/2020.
//

import SwiftUI
import Combine

final class MealGenerator: ObservableObject {
    
    let urlString: String = "https://www.themealdb.com/api/json/v1/1/random.php"
    
    @Published var currentMeal: Meal?
    
    @Published var currentImageURLString: String?
    private var cancellable: AnyCancellable?
    
    func fetchRandomMeal() {
        if let url = URL(string: urlString) {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main) //
                .sink{ (_) in
                    
                } receiveValue: { (data, response) in
                    if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                        self.currentMeal = mealData.meals.first
                        self.currentImageURLString = mealData.meals.first?.imageUrlString
                    }
                }
            
        }
        
        
    }
    
    
}
