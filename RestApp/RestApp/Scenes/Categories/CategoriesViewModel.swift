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
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
    var getShareableInfo: GetShareableInfo = GetShareableInfoAdapter()
  }
  private let dependencies: Dependencies
  
  var rowItemsPublisher: AnyPublisher<[RowItem], Never> {
    return dependencies.restaurantService.categoriesPublisher.map { categories in
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
    dependencies.restaurantService.getRestaurants()
  }
  
  func rateRestaurant(restaurantID: String, score: Int, comment: String) {
    dependencies.restaurantService.rateRestaurant(restaurantID: restaurantID, comment: comment, score: score)
  }
  
  func getRestaurant(for restaurantID: String) -> Restaurant? {
    return dependencies.restaurantService.getRestaurant(restaurantID: restaurantID)
  }
  
  func getShareableItems(for restaurantID: String) -> [Any] {
    guard let restaurant = dependencies.restaurantService.getRestaurant(restaurantID: restaurantID) else { return [] }
    return dependencies.getShareableInfo.execute(for: restaurant)
  }
}
