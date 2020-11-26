//
//  GetRestaurantsPublisher.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation
import Combine

protocol GetRestaurantsPublisher {
  func execute() -> AnyPublisher<[Category], Never>
}

final class GetRestaurantsPublisherAdapter: GetRestaurantsPublisher {
  struct Dependecies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
  }
  private let dependencies: Dependecies
  
  init(dependencies: Dependecies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute() -> AnyPublisher<[Category], Never> {
    return dependencies.restaurantService.categoriesPublisher
  }
}
