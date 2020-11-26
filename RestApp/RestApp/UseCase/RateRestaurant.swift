//
//  RateRestaurant.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation

protocol RateRestaurant {
  func execute(restaurantID: String, comment: String, score: Int)
}

final class RateRestaurantAdapter: RateRestaurant {
  struct Dependencies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
    var restaurantsCache: RestaurantCache = RestaurantCacheAdapter.shared
    var restaurantAPI: RestaurantAPI = RestaurantAPIAdapter()
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(restaurantID: String, comment: String, score: Int) {
    guard let categoryID = dependencies.restaurantService.getCategoryID(for: restaurantID) else { return }
    dependencies.restaurantAPI.rateRestaurant(restaurantID: restaurantID, categoryID: categoryID,
                                              comment: comment, score: score) { [weak self] categories in
      self?.dependencies.restaurantsCache.set(categories)
      self?.dependencies.restaurantService.update(categories: categories)
    }
  }
}
