//
//  ScenePresenter.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import Foundation

extension Category {
  var viewModel: CategoryViewModel {
    return CategoryViewModel(name: self.name, systemIconName: self.iconImageName)
  }
}

extension Restaurant {
  var viewModel: RestaurantViewModel {
    return RestaurantViewModel(id: restaurantID, imageName: imageName, name: name, description: description, hasRatings: !ratings.isEmpty)
  }
}

extension Rating {
  var viewModel: RatingViewModel {
    return RatingViewModel(id: ratingID, comment: comment, score: Int(score) ?? 0)
  }
}
