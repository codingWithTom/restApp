//
//  FavoritesViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-17.
//

import UIKit
import Combine

final class FavoritesViewController: UIViewController {
  
  private var favoritesSubscriber: AnyCancellable?
  private let viewModel = FavoritesViewModel()
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, RestaurantViewModel>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureDataSource()
    favoritesSubscriber = viewModel.favoritesPublisher.receive(on: RunLoop.main).sink { [weak self] in
      self?.updateDataSource(with: $0)
    }
  }
}

extension FavoritesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard
      let restaurantViewModel = dataSource?.itemIdentifier(for: indexPath),
      let restaurant = viewModel.getRestaurant(for: restaurantViewModel.id),
      let restaurantController = RestaurantDetailViewController.getController(for: restaurant)
    else { return }
    showDetailViewController(restaurantController, sender: self)
  }
}

private extension FavoritesViewController {
  func configureView() {
    var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
    configuration.leadingSwipeActionsConfigurationProvider = { [weak self] indexPath in
          guard let item = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
          return self?.getSwipeConfiguration(for: item)
        }
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.delegate = self
  }
  
  func getSwipeConfiguration(for restaurantViewModel: RestaurantViewModel) -> UISwipeActionsConfiguration? {
    let removeAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completion in
      self?.viewModel.removeFavorite(forRestaurantID: restaurantViewModel.id)
      completion(true)
    }
    removeAction.image = UIImage(systemName: "xmark.circle.fill")
    return UISwipeActionsConfiguration(actions: [removeAction])
  }
  
  func configureDataSource() {
    let restauranteCellRegistration = UICollectionView.CellRegistration<RestaurantCollectionViewCell, RestaurantViewModel> { cell, _, restaurantViewModel in
      cell.update(with: restaurantViewModel)
      cell.accessories = restaurantViewModel.hasRatings ? [.outlineDisclosure()] : []
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, RestaurantViewModel>(collectionView: collectionView) { collectionView, indexPath, item in
      return collectionView.dequeueConfiguredReusableCell(using: restauranteCellRegistration, for: indexPath, item: item)
    }
  }
  
  func updateDataSource(with viewModels: [RestaurantViewModel]) {
    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<RestaurantViewModel>()
    sectionSnapshot.append(viewModels)
    dataSource?.apply(sectionSnapshot, to: .first)
  }
}
