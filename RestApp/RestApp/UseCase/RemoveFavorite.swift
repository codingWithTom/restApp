//
//  RemoveFavorite.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation

protocol RemoveFavorite {
  func execute(restaurantID: String)
}

final class RemoveFavoriteAdapter: RemoveFavorite {
  struct Dependencies {
    var favoritesService: FavoritesService = FavoritesServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(restaurantID: String) {
    dependencies.favoritesService.remove(restaurantWithID: restaurantID)
  }
}
