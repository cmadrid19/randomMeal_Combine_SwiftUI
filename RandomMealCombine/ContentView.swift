//
//  ContentView.swift
//  RandomMealCombine
//
//  Created by Maxim Macari on 21/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var mealGenerator =  MealGenerator()
    
    var body: some View {
        
        
        VStack {
            Button(action: {
                mealGenerator.fetchRandomMeal()
            }, label: {
                Text("Get random meal")
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(16)
            .onAppear {
                mealGenerator.fetchRandomMeal()
            }
            
            
            if let name = mealGenerator.currentMeal?.name{
                Text("\(name)")
                    .font(.largeTitle)
                
            }
            
            
            
            ScrollView(showsIndicators: false){
                
                AsyncImageView(urlString: $mealGenerator.currentImageURLString)
                
                if let ingredients = mealGenerator.currentMeal?.ingredients {
                    HStack{
                        Spacer()
                        Text("Ingredients: ")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    ForEach(ingredients, id: \.self){ ingredient in
                        HStack{
                            Text("\(ingredient.name) - \(ingredient.measure)" )
                            Spacer(minLength: 0)
                        }
                    }
                }
                
                if let instructions = mealGenerator.currentMeal?.instructions {
                    VStack{
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("\(instructions)")
                    }
                    
                }
            }
            .padding(.horizontal, 10)
            
        }
        .padding(10)
        .padding(.trailing, 10)
        .animation(.linear)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
