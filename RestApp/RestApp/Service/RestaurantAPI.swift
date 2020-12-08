//
//  RestaurantAPI.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation

protocol RestaurantAPI {
  func getRestaurants(completion: @escaping ([Category]) -> Void)
  func rateRestaurant(restaurantID: String, categoryID: String, comment: String, score: Int, completion: @escaping ([Category]) -> Void)
}

final class RestaurantAPIAdapter: RestaurantAPI {
  private let domain = "localhost:3000"
  
  func getRestaurants(completion: @escaping ([Category]) -> Void) {
    guard let url = URL(string: "http://\(domain)/restaurants") else { return }
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self] data, _, _ in
      self?.hadleResponse(with: data, completion: completion)
    }
    task.resume()
  }
  
  func rateRestaurant(restaurantID: String, categoryID: String, comment: String, score: Int, completion: @escaping ([Category]) -> Void) {
    let rateBody = ["score": "\(score)", "comment": comment]
    guard
      let url = URL(string: "http://\(domain)/restaurants/\(categoryID)/\(restaurantID)"),
      let rateData = try? JSONEncoder().encode(rateBody)
    else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = rateData
    let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
      self?.hadleResponse(with: data, completion: completion)
    }
    task.resume()
  }
}

private extension RestaurantAPIAdapter {
  func hadleResponse(with data: Data?, completion: @escaping ([Category]) -> Void) {
    let jsonDecoder = JSONDecoder()
    guard
      let data = data,
      let categories = try? jsonDecoder.decode([Category].self, from: data)
    else { return }
    completion(categories)
  }
}
