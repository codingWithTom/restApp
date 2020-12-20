//
//  AddFavorite.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation

protocol AddFavorite {
  func execute(restaurant: Restaurant)
}

final class AddFavoriteAdapter: AddFavorite {
  struct Dependencies {
    var favoritesService: FavoritesService = FavoritesServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(restaurant: Restaurant) {
    dependencies.favoritesService.add(restaurant)
  }
}
