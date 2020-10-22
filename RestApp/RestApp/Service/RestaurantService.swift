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
  func getRestaurants()
  func rateRestaurant(restaurantID: String, comment: String, score: Int)
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
  
  func getRestaurants() {
    guard let url = URL(string: "http://localhost:3000/restaurants") else { return }
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self] data, _, _ in
      self?.updateCategories(with: data)
    }
    task.resume()
  }
  
  func rateRestaurant(restaurantID: String, comment: String, score: Int) {
    let category = categories.first { category in category.restaurants.contains { $0.restaurantID == restaurantID } }
    let rateBody = ["score": "\(score)", "comment": comment]
    guard
      let categoryID = category?.categoryID,
      let url = URL(string: "http://localhost:3000/restaurants/\(categoryID)/\(restaurantID)"),
      let rateData = try? JSONEncoder().encode(rateBody)
    else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = rateData
    let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
      self?.updateCategories(with: data)
    }
    task.resume()
  }
}

private extension RestaurantServiceAdapter {
  func updateCategories(with data: Data?) {
    let jsonDecoder = JSONDecoder()
    guard
      let data = data,
      let categories = try? jsonDecoder.decode([Category].self, from: data)
    else { return }
    self.categories = categories
  }
}
