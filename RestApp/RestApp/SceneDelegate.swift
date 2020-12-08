//
//  SceneDelegate.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  struct DeepLinkKeys {
    static let codingWithTomScheme = "cwt"
    static let restaurantPathComponent = "restaurant"
    static let restaurantQueryItem = "restaurantID"
  }
  struct Dependencies {
    var getRestaurant: GetRestaurant = GetRestaurantAdapter()
  }
  
  private var dependencies = Dependencies()
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if let context = connectionOptions.urlContexts.first {
      handleURLContext(context)
    }
    guard let _ = (scene as? UIWindowScene) else { return }
  }
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let context = URLContexts.first {
      handleURLContext(context)
    }
  }
}

private extension SceneDelegate {
  func handleURLContext(_ context: UIOpenURLContext) {
      // cwt://restApp/restaurant?restaurantID=M3
    let url = context.url
    if url.scheme == DeepLinkKeys.codingWithTomScheme, url.lastPathComponent == DeepLinkKeys.restaurantPathComponent {
      openRestaurant(for: url)
    }
  }
  
  func openRestaurant(for url: URL) {
    let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
    guard
      let restaurantID = components?.queryItems?.first(where: { $0.name == DeepLinkKeys.restaurantQueryItem })?.value,
      let restaurant = dependencies.getRestaurant.execute(restaurantID: restaurantID),
      let restaurantVC = RestaurantDetailViewController.getController(for: restaurant)
    else { return }
    window?.rootViewController?.show(restaurantVC, sender: self)
  }
}

