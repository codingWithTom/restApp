//
//  GetRestaurantsPublisher.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation
import Combine

protocol GetRestaurantsPublisher {
  func execute() -> AnyPublisher<[Category], Never>
  func updateCategoriesFor(text: String?, dishType: DishType)
}

final class GetRestaurantsPublisherAdapter: GetRestaurantsPublisher {
  struct Dependecies {
    var restaurantService: RestaurantService = RestaurantServiceAdapter.shared
  }
  private let dependencies: Dependecies
  private var categories: [Category] = []
  private var currentValueCategories = CurrentValueSubject<[Category], Never>([])
  private var anyCancellable: AnyCancellable?
  
  init(dependencies: Dependecies = .init()) {
    self.dependencies = dependencies
    anyCancellable = dependencies.restaurantService.categoriesPublisher.sink { [weak self] in
      self?.categories = $0
      self?.currentValueCategories.value = $0
    }
  }
  
  func execute() -> AnyPublisher<[Category], Never> {
    return currentValueCategories.eraseToAnyPublisher()
  }
  
  func updateCategoriesFor(text: String?, dishType: DishType) {
    guard let searchText = text, !searchText.isEmpty else {
      currentValueCategories.value = categories
      return
    }
    currentValueCategories.value = getCategoriesFor(text: searchText, dishType: dishType)
  }
}

private extension GetRestaurantsPublisherAdapter {
  func getCategoriesFor(text: String, dishType: DishType) -> [Category] {
    var restaurants = categories.flatMap { category in category.restaurants }
    restaurants = restaurants.filter { $0.name.contains(text) }
    if dishType != .none {
      restaurants = restaurants.filter { $0.dishTypes.contains(dishType) }
    }
    return [Category(categoryID: "Filtered", name: "Filtered", iconImageName: "magnifyingglass", restaurants: restaurants)]
  }
}
