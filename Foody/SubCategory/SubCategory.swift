//
//  SubCategory.swift
//  Foody
//
//  Created by Merve Nurgül BAĞCI on 12.05.2023.
//

import UIKit

struct Meals: Codable {
    let meals: [SubCategory]
}

struct SubCategory: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

