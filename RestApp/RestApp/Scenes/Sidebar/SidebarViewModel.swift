//
//  SidebarViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation
import Combine

final class SidebarViewModel {
  struct Dependencies {
    var getFavoritesPublisher: GetFavoritesPublisher = GetFavoritesPublisherAdapter()
    var addFavorite: AddFavorite = AddFavoriteAdapter()
    var removeFavorite: RemoveFavorite = RemoveFavoriteAdapter()
    var getRestaurant: GetRestaurant = GetRestaurantAdapter()
  }
  private let dependencies: Dependencies
  var favorites: AnyPublisher<[RestaurantViewModel], Never> {
    return dependencies.getFavoritesPublisher.execute().map { favorites in
      favorites.map { $0.viewModel }
    }.eraseToAnyPublisher()
  }
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func addFavorite(restaurantDropItem: RestaurantDropItem) {
    dependencies.addFavorite.execute(restaurant: restaurantDropItem.restaurant)
  }
  
  func removeFavorite(withID restaurantID: String) {
    dependencies.removeFavorite.execute(restaurantID: restaurantID)
  }
  
  func restaurant(for restaurantID: String) -> Restaurant? {
    return dependencies.getRestaurant.execute(restaurantID: restaurantID)
  }
}
