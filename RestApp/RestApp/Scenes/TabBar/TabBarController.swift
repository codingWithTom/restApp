//
//  TabBarController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import UIKit
import Combine

final class TabBarController: UITabBarController {
  
  private let viewModel = TabBarViewModel()
  private var favoritesSubscriber: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.addInteraction(UIDropInteraction(delegate: self))
    favoritesSubscriber = viewModel.numberOfFavorites.receive(on: RunLoop.main).sink { [weak self] in
      self?.updateFavoritesCounter(numberOfFavorites: $0)
    }
  }
}

extension TabBarController: UIDropInteractionDelegate {
  func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
    return session.hasItemsConforming(toTypeIdentifiers: ["public.data"])
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    return UIDropProposal(operation: .copy)
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    session.loadObjects(ofClass: RestaurantDropItem.self) { [weak self] items in
      guard let dropItems = items as? [RestaurantDropItem] else { return }
      dropItems.forEach { self?.viewModel.addFavorite(restaurantDropItem: $0) }
    }
  }
}

private extension TabBarController {
  func updateFavoritesCounter(numberOfFavorites: Int) {
    tabBar.items?.last?.badgeValue = numberOfFavorites > 0 ? "\(numberOfFavorites)" : nil
  }
}
