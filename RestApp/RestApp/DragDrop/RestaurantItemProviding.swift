//
//  RestaurantItemProviding.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import UIKit

final class RestaurantDragItem: NSObject, NSItemProviderWriting {
  static var writableTypeIdentifiersForItemProvider: [String] { return ["public.data"]}
  
  let restaurant: Restaurant
  
  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }
  
  func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
    do {
      let data = try JSONEncoder().encode(restaurant)
      completionHandler(data, nil)
    } catch {
      completionHandler(nil, error)
    }

    return Progress(totalUnitCount: 100)
  }
}

final class RestaurantDropItem: NSObject, NSItemProviderReading {
  static var readableTypeIdentifiersForItemProvider: [String] { return ["public.data"] }

  let restaurant: Restaurant
  
  init(restaurant: Restaurant) {
    self.restaurant = restaurant
  }
  
  static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> RestaurantDropItem {
    let restaurant = try JSONDecoder().decode(Restaurant.self, from: data)
    return RestaurantDropItem(restaurant: restaurant)
  }
}
