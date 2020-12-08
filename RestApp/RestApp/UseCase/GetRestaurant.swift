//
//  GetRestaurant.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation

protocol GetRestaurant {
  func execute(restaurantID: String) -> Restaurant?
}

final class GetRestaurantAdapter: GetRestaurant {
  struct Dependencies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(restaurantID: String) -> Restaurant? {
    return dependencies.restaurantService.getRestaurant(restaurantID: restaurantID)
  }
}
