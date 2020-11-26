//
//  CategoriesViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-10-21.
//

import Foundation
import Combine

final class CategoriesViewModel {
  struct Dependencies {
    var getRestaurantsPublisher: GetRestaurantsPublisher = GetRestaurantsPublisherAdapter()
    var getShareableInfo: GetShareableInfo = GetShareableInfoAdapter()
    var getRestaurant: GetRestaurant = GetRestaurantAdapter()
    var fetchRestaurants: FetchRestaurants = FetchRestaurantsAdapter()
    var rateRestaurant: RateRestaurant = RateRestaurantAdapter()
  }
  private let dependencies: Dependencies
  
  var rowItemsPublisher: AnyPublisher<[RowItem], Never> {
    return dependencies.getRestaurantsPublisher.execute().map { categories in
      categories.map { category in
        RowItem(item: Item.category(category.viewModel),
                children: category.restaurants.map { restaurant in
                  RowItem(item: Item.restaurant(restaurant.viewModel),
                          children: restaurant.ratings.map { RowItem(item: Item.rating($0.viewModel), children: []) })
                })
      }
    }.eraseToAnyPublisher()
  }
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func handleSceneLoaded() {
    dependencies.fetchRestaurants.execute()
  }
  
  func rateRestaurant(restaurantID: String, score: Int, comment: String) {
    dependencies.rateRestaurant.execute(restaurantID: restaurantID, comment: comment, score: score)
  }
  
  func getRestaurant(for restaurantID: String) -> Restaurant? {
    return dependencies.getRestaurant.execute(restaurantID: restaurantID)
  }
  
  func getShareableItems(for restaurantID: String) -> [Any] {
    guard let restaurant = dependencies.getRestaurant.execute(restaurantID: restaurantID) else { return [] }
    return dependencies.getShareableInfo.execute(for: restaurant)
  }
}
