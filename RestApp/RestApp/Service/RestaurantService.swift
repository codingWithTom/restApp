//
//  RestaurantService.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import Foundation
import Combine

protocol RestaurantService {
  var categoriesPublisher: AnyPublisher<[Category], Never> { get }
  func getRestaurant(restaurantID: String) -> Restaurant?
  func getCategoryID(for restaurantID: String) -> String?
  func update(categories: [Category])
}

final class RestaurantServiceAdapter: RestaurantService {
  static let shared = RestaurantServiceAdapter()
  private var categories: [Category] = [] {
    didSet {
      currentSubjectPublisher.value = categories
    }
  }
  private var currentSubjectPublisher = CurrentValueSubject<[Category], Never>([])
  var categoriesPublisher: AnyPublisher<[Category], Never> {
    return currentSubjectPublisher.eraseToAnyPublisher()
  }
  private init() {}
  
  func getRestaurant(restaurantID: String) -> Restaurant? {
    for category in categories {
      if let restaurant = category.restaurants.first(where: { $0.restaurantID == restaurantID }) {
        return restaurant
      }
    }
    return nil
  }
  
  func getCategoryID(for restaurantID: String) -> String? {
    let category = categories.first { category in category.restaurants.first { $0.restaurantID == restaurantID } != nil }
    return category?.categoryID
  }
  
  func update(categories: [Category]) {
    self.categories = categories
  }
}
