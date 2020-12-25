//
//  ScheduleNotificationForRestaurant.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-23.
//

import Foundation

protocol ScheduleNotificationForRestaurant {
  func execute(_: Restaurant, completion: @escaping (Bool) -> Void)
}

final class ScheduleNotificationForRestaurantAdapter: ScheduleNotificationForRestaurant {
  struct Dependencies {
    var notificationService: UserNotificationService = UserNotificationServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute(_ restaurant: Restaurant, completion: @escaping (Bool) -> Void) {
    dependencies.notificationService.scheduleNotificationFor(restaurant: restaurant, completion: completion)
  }
}
