//
//  RetrieveRestaurants.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation

protocol RetrieveRestaurants {
  func execute()
}

final class RetrieveRestaurantsAdapter: RetrieveRestaurants {
  struct Dependencies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
    var restaurantCache: RestaurantCache = RestaurantCacheAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute() {
    let categories = dependencies.restaurantCache.get()
    dependencies.restaurantService.update(categories: categories)
  }
}
