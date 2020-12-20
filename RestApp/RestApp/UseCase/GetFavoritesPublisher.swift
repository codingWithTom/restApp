//
//  GetFavoritesPublisher.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation
import Combine

protocol GetFavoritesPublisher {
  func execute() -> AnyPublisher<[Restaurant], Never>
}

final class GetFavoritesPublisherAdapter: GetFavoritesPublisher {
  struct Dependencies {
    var favoritesService: FavoritesService = FavoritesServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute() -> AnyPublisher<[Restaurant], Never> {
    return dependencies.favoritesService.favoritesPublisher
  }
}
