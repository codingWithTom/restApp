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
    if let windowScene = (scene as? UIWindowScene),
       window?.traitCollection.userInterfaceIdiom == .pad,
       let rootViewController = makeSplitViewController() {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = rootViewController
      self.window = window
      window.makeKeyAndVisible()
    } else {
      (window?.rootViewController as? UISplitViewController)?.delegate = self
    }
  }
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let context = URLContexts.first {
      handleURLContext(context)
    }
  }
}

extension SceneDelegate: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
    guard let tabController = splitViewController.viewControllers.first as? UITabBarController else { return false }
    var viewControllerToShow = vc
    if let nav = vc as? UINavigationController, let topController = nav.topViewController {
      viewControllerToShow = topController
    }
    tabController.selectedViewController?.show(viewControllerToShow, sender: self)
    return true
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
  
  func makeSplitViewController() -> UIViewController? {
    guard let categoriesController = CategoriesViewController.instantiateFromStoryboard() else { return nil }
    let splitViewController = UISplitViewController(style: .tripleColumn)
    splitViewController.preferredDisplayMode = .twoBesideSecondary
    splitViewController.setViewController(SidebarViewController(), for: .primary)
    splitViewController.setViewController(UINavigationController(rootViewController: categoriesController), for: .supplementary)
    return splitViewController
  }
}

