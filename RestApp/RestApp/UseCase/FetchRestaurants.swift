//
//  FetchRestaurants.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation

protocol FetchRestaurants {
  func execute()
}

final class FetchRestaurantsAdapter: FetchRestaurants {
  struct Dependencies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
    var restaurantsCache: RestaurantCache = RestaurantCacheAdapter.shared
    var restaurantAPI: RestaurantAPI = RestaurantAPIAdapter()
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute() {
    dependencies.restaurantAPI.getRestaurants { [weak self] categories in
      self?.dependencies.restaurantsCache.set(categories)
      self?.dependencies.restaurantService.update(categories: categories)
    }
  }
}
