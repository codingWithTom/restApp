//
//  Restaurant.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import Foundation

enum DishType: String, CaseIterable, Codable {
  case none = "None"
  case vegetarian = "Vegetarian"
  case vegan = "Vegan"
  case glutenFree = "Gluten Free"
}

struct Restaurant: Codable {
  let restaurantID: String
  let name: String
  let description: String
  let imageName: String
  let ratings: [Rating]
  let images: [String]
  let dishTypes: [DishType]
}
