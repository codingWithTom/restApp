//
//  CategoriesViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-10-21.
//

import Foundation
import Combine

final class CategoriesViewModel {
  struct Dependencies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  var rowItemsPublisher: AnyPublisher<[RowItem], Never> {
    return dependencies.restaurantService.categoriesPublisher.map { categories in
      categories.map { category in
        RowItem(item: Item.category(category.viewModel),
                children: category.restaurants.map { restaurant in
                  RowItem(item: Item.restaurant(restaurant.viewModel),
                          children: restaurant.ratings.map { RowItem(item: Item.rating($0.viewModel), children: []) })
                })
      }
    }.eraseToAnyPublisher()
  }
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func handleSceneLoaded() {
    dependencies.restaurantService.getRestaurants()
  }
  
  func rateRestaurant(restaurantID: String, score: Int, comment: String) {
    dependencies.restaurantService.rateRestaurant(restaurantID: restaurantID, comment: comment, score: score)
  }
}

private extension Category {
  var viewModel: CategoryViewModel {
    return CategoryViewModel(name: self.name, systemIconName: self.iconImageName)
  }
}

private extension Restaurant {
  var viewModel: RestaurantViewModel {
    return RestaurantViewModel(id: restaurantID, imageName: imageName, name: name, description: description, hasRatings: !ratings.isEmpty)
  }
}

private extension Rating {
  var viewModel: RatingViewModel {
    return RatingViewModel(id: ratingID, comment: comment, score: Int(score) ?? 0)
  }
}
