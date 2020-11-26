//
//  RestaurantCache.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-26.
//

import Foundation

protocol RestaurantCache {
  func get() -> [Category]
  func set(_: [Category])
}

final class RestaurantCacheAdapter: RestaurantCache {
  static let shared = RestaurantCacheAdapter()
  
  private var categoriesFileURL: URL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return URL(fileURLWithPath: "categories", relativeTo: documentsURL)
  }
  
  private init() {}
  
  func get() -> [Category] {
    guard
      let data = try? Data(contentsOf: categoriesFileURL),
      let categories = try? JSONDecoder().decode([Category].self, from: data)
    else { return [] }
    return categories
  }
  
  func set(_ categories: [Category]) {
    guard let data = try? JSONEncoder().encode(categories) else { return }
    do {
      try data.write(to: categoriesFileURL)
    } catch {
      print("error saving data \(error)")
    }
  }
}
