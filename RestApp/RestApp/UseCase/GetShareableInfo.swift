//
//  GetShareableInfo.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import UIKit

protocol GetShareableInfo {
  func execute(for: Restaurant) -> [Any]
}

final class GetShareableInfoAdapter: GetShareableInfo {
  func execute(for restaurant: Restaurant) -> [Any] {
    guard let image = UIImage(named: restaurant.imageName) else { return [] }
    return [
      "Checkout this restaurant - \(restaurant.name)",
      image
    ]
  }
}
