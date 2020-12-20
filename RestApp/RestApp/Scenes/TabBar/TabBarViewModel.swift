//
//  TabBarViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation
import Combine

final class TabBarViewModel {
  struct Dependencies {
    var getFavorites: GetFavoritesPublisher = GetFavoritesPublisherAdapter()
    var addFavorite: AddFavorite = AddFavoriteAdapter()
  }
  private let dependencies: Dependencies
  var numberOfFavorites: AnyPublisher<Int, Never> {
    return dependencies.getFavorites.execute().map {
      $0.count
    }.eraseToAnyPublisher()
  }
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func addFavorite(restaurantDropItem: RestaurantDropItem) {
    dependencies.addFavorite.execute(restaurant: restaurantDropItem.restaurant)
  }
}
