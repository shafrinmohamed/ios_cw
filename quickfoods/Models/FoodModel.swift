//
//  FoodModel.swift
//  quickfoods
//
//  Created by shafrin on 05/02/2023.
//

import Foundation

struct FoodModel: Codable {
    let success: Bool
    let data: [Data]
    let message: String
}

// MARK: - Datum
struct Data: Codable {
    let name, price: String
    let ratings: Int
    let description, calories, nutritionLevel: String
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case name, price, ratings, description, calories
        case nutritionLevel = "nutrition_level"
        case imagePath = "image_path"
    }
}



