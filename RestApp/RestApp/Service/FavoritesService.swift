//
//  FavoritesService.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import Foundation
import Combine

protocol FavoritesService {
  var favoritesPublisher: AnyPublisher<[Restaurant], Never> { get }
  func add(_: Restaurant)
  func remove(restaurantWithID: String)
}

final class FavoritesServiceAdapter: FavoritesService {
  static let shared = FavoritesServiceAdapter()
  
  private var favorites: [Restaurant] = [] {
    didSet {
      currentFavorites.value = favorites
    }
  }
  private var favoritesURL: URL {
    let userDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return URL(fileURLWithPath: "favorites", relativeTo: userDirectory)
  }
  private var currentFavorites = CurrentValueSubject<[Restaurant], Never>([])
  var favoritesPublisher: AnyPublisher<[Restaurant], Never> {
    return currentFavorites.eraseToAnyPublisher()
  }
  
  private init() {
    retrieveSavedFavorites()
  }
  
  func add(_ restaurant: Restaurant) {
    guard favorites.first(where: { $0.restaurantID == restaurant.restaurantID }) == nil else { return }
    favorites.append(restaurant)
    updateSavedFavorites()
  }
  
  func remove(restaurantWithID restaurantID: String) {
    guard let index = favorites.firstIndex(where: { $0.restaurantID == restaurantID }) else { return }
    favorites.remove(at: index)
    updateSavedFavorites()
  }
}

private extension FavoritesServiceAdapter {
  func retrieveSavedFavorites() {
    guard
      let favoritesData = try? Data(contentsOf: favoritesURL),
      let favorites = try? JSONDecoder().decode([Restaurant].self, from: favoritesData)
    else { return }
    self.favorites = favorites
  }
  
  func updateSavedFavorites() {
    do {
      let data = try JSONEncoder().encode(favorites)
      try data.write(to: favoritesURL)
    } catch {
      print("Error saving favorites: \(error)")
    }
  }
}
