//
//  FavoritesViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation
import Combine

final class FavoritesViewModel {
  struct Dependencies {
    var getFavorites: GetFavoritesPublisher = GetFavoritesPublisherAdapter()
    var removeFavorite: RemoveFavorite = RemoveFavoriteAdapter()
    var getRestaurant: GetRestaurant = GetRestaurantAdapter()
  }
  private let dependencies: Dependencies
  var favoritesPublisher: AnyPublisher<[RestaurantViewModel], Never> {
    return dependencies.getFavorites.execute().map { favorites in
      favorites.map { $0.viewModel }
    }.eraseToAnyPublisher()
  }
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func getRestaurant(for restaurantID: String) -> Restaurant? {
    return dependencies.getRestaurant.execute(restaurantID: restaurantID)
  }
  
  func removeFavorite(forRestaurantID restaurantID: String) {
    dependencies.removeFavorite.execute(restaurantID: restaurantID)
  }
}
