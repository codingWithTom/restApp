//
//  UserNotificationService.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-23.
//

import Foundation
import UserNotifications
import Combine

protocol UserNotificationService {
  var restaurantNotificationPublisher: AnyPublisher<String, Never> { get }
  func scheduleNotificationFor(restaurant: Restaurant, completion: @escaping (Bool) -> Void)
}

final class UserNotificationServiceAdapter: NSObject, UserNotificationService {
  static let shared = UserNotificationServiceAdapter()
  
  private var passthroughPublisher = PassthroughSubject<String, Never>()
  var restaurantNotificationPublisher: AnyPublisher<String, Never> {
    return passthroughPublisher.eraseToAnyPublisher()
  }
  
  private override init() {
    super.init()
    let center = UNUserNotificationCenter.current()
    center.delegate = self
  }
  
  func scheduleNotificationFor(restaurant: Restaurant, completion: @escaping (Bool) -> Void) {
    // Check for user settings
    let center = UNUserNotificationCenter.current()
    center.getNotificationSettings { [weak self] settings in
      if settings.authorizationStatus == .notDetermined {
        // Request for permission
        self?.askForNotificationPermission(for: restaurant, completion: completion)
      } else if settings.authorizationStatus == .denied {
        completion(false)
      } else {
        self?.scheduleLocalNotificaitonFor(restaurant: restaurant, completion: completion)
        completion(true)
      }
    }
  }
}

extension UserNotificationServiceAdapter: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.sound, .banner])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()
    let restaurantID = response.notification.request.identifier
    passthroughPublisher.send(restaurantID)
  }
}

private extension UserNotificationServiceAdapter {
  func askForNotificationPermission(for restaurant: Restaurant, completion: @escaping (Bool) -> Void) {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.sound, .alert]) { [weak self] isPermissionGranted, _ in
      guard isPermissionGranted else {
        completion(false)
        return
      }
      self?.scheduleLocalNotificaitonFor(restaurant: restaurant, completion: completion)
    }
  }
  
  func scheduleLocalNotificaitonFor(restaurant: Restaurant, completion: @escaping (Bool) -> Void) {
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    content.title = "\(restaurant.name) is Open!"
    content.body = "Make sure to book a table or visit their website!"
    content.sound = UNNotificationSound(named: UNNotificationSoundName("NotificaitonSound.aiff"))
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let request = UNNotificationRequest(identifier: restaurant.restaurantID, content: content, trigger: trigger)
    center.add(request, withCompletionHandler: nil)
    completion(true)
  }
}
