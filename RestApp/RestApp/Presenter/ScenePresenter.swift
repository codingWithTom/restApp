//
//  ScenePresenter.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import UIKit

extension Category {
  var viewModel: CategoryViewModel {
    return CategoryViewModel(name: self.name, systemIconName: self.iconImageName)
  }
}

extension Restaurant {
  var viewModel: RestaurantViewModel {
    return RestaurantViewModel(id: restaurantID, imageName: imageName, name: name, description: description, hasRatings: !ratings.isEmpty, labels: dishTypes.map(label(for:)))
  }
  
  private func label(for dishType: DishType) -> (text: String, color: UIColor) {
    switch dishType {
    case .vegan:
      return (text: "Vg", color: UIColor(red: 69 / 255, green: 123 / 255, blue: 157 / 255, alpha: 1.0))
    case .vegetarian:
      return (text: "Veg", color: UIColor(red: 0 / 255, green: 109 / 255, blue: 119 / 255, alpha: 1.0))
    case .glutenFree:
      return (text: "GF", color: UIColor(red: 228 / 255, green: 37 / 255, blue: 53 / 255, alpha: 1.0))
    default:
      return (text: "", color: .clear)
    }
  }
}

extension Rating {
  var viewModel: RatingViewModel {
    return RatingViewModel(id: ratingID, comment: comment, score: Int(score) ?? 0)
  }
}
