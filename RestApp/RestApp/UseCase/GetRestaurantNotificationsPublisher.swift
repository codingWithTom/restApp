//
//  GetRestaurantNotificationsPublisher.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-23.
//

import Foundation
import Combine

protocol GetRestaurantNotificationsPublisher {
  func execute() -> AnyPublisher<String, Never>
}

final class GetRestaurantNotificationsPublisherAdapter: GetRestaurantNotificationsPublisher {
  struct Dependencies {
    var notificationService: UserNotificationService = UserNotificationServiceAdapter.shared
  }
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies = .init()) {
    self.dependencies = dependencies
  }
  
  func execute() -> AnyPublisher<String, Never> {
    return dependencies.notificationService.restaurantNotificationPublisher
  }
}
