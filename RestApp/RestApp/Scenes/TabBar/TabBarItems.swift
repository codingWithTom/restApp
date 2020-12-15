//
//  TabBarItems.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-13.
//

import UIKit

enum TabBarItems: CaseIterable {
  case restaurants
  case profile
  
  var title: String {
    switch self {
    case .restaurants: return "Restaurants"
    case .profile: return "Profile"
    }
  }
  
  var image: UIImage? {
    switch self {
    case .restaurants: return UIImage(systemName: "list.bullet.rectangle")
    case .profile: return UIImage(systemName: "person.circle.fill")
    }
  }
}
