//
//  RestaurantService.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import Foundation

protocol RestaurantService {
  func getRestaurants(completion: @escaping ([Category]) -> Void)
}

final class RestaurantServiceAdapter: RestaurantService {
  static let shared = RestaurantServiceAdapter()
  
  private init() {}
  
  func getRestaurants(completion: @escaping ([Category]) -> Void) {
    guard let url = URL(string: "http://localhost:3000/restaurants") else { return }
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
      let jsonDecoder = JSONDecoder()
      guard
        let data = data,
        let categories = try? jsonDecoder.decode([Category].self, from: data)
      else { return }
      completion(categories)
    }
    task.resume()
  }
}
