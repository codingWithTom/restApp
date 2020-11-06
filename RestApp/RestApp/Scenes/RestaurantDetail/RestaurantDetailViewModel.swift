//
//  RestaurantDetailViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import Foundation

final class RestaurantDetailViewModel {
  struct Dependencies {
    var getShareableInfo: GetShareableInfo = GetShareableInfoAdapter()
  }
  private let dependencies: Dependencies
  private let restaurant: Restaurant
  var restaurantImageName: String { return restaurant.imageName }
  var restaurantDescription: String { return restaurant.description }
  var title: String { return restaurant.name }
  
  init(dependencies: Dependencies = .init(), restaurant: Restaurant) {
    self.dependencies = dependencies
    self.restaurant = restaurant
  }
  
  func getRatingItems() -> [RatingViewModel] {
    return restaurant.ratings.map { $0.viewModel }
  }
  
  func getShareableItems() -> [Any] {
    return dependencies.getShareableInfo.execute(for: restaurant)
  }
}
