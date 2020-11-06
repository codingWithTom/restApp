//
//  CategoriesViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import UIKit
import Combine

enum Section: Hashable {
  case first
}

struct RowItem {
  let item: Item
  let children: [RowItem]
}

enum Item: Hashable {
  case category(CategoryViewModel)
  case restaurant(RestaurantViewModel)
  case rating(RatingViewModel)
}

struct CategoryViewModel: Hashable {
  let name: String
  let systemIconName: String
}

struct RestaurantViewModel: Hashable {
  let id: String
  let imageName: String
  let name: String
  let description: String
  let hasRatings: Bool
}

struct RatingViewModel: Hashable {
  let id: String
  let comment: String
  let score: Int
}

final class CategoriesViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  private let viewModel = CategoriesViewModel()
  private var rowItemsCancellable: AnyCancellable?
  private var idOfRestaurantBeingRated: String?
  private var rateView: UIView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    viewModel.handleSceneLoaded()
    rowItemsCancellable = viewModel.rowItemsPublisher.sink { [weak self] items in
      DispatchQueue.main.async {
        self?.updateUI(with: items)
      }
    }
  }
}

private extension CategoriesViewController {
  func configureCollectionView() {
    let layout = UICollectionViewCompositionalLayout { Section, environment in
      var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      listConfiguration.leadingSwipeActionsConfigurationProvider = { [weak self] indexPath in
        guard let item = self?.dataSource.itemIdentifier(for: indexPath) else { return nil }
        return self?.getSwipeConfiguration(for: item)
      }
      return NSCollectionLayoutSection.list(using: listConfiguration, layoutEnvironment: environment)
    }
    collectionView.collectionViewLayout = layout
    collectionView.delegate = self
    configureDataSource()
  }
  
  func getSwipeConfiguration(for item: Item) -> UISwipeActionsConfiguration? {
    guard case let .restaurant(restaurantViewModel) = item else { return nil }
    let rateAction = UIContextualAction(style: .normal, title: "Rate") { [weak self] _, _, completion in
      self?.presentRateView(for: restaurantViewModel)
      completion(true)
    }
    rateAction.backgroundColor = .systemBlue
    rateAction.image = UIImage(systemName: "star.fill")
    return UISwipeActionsConfiguration(actions: [rateAction])
  }
  
  func configureDataSource() {
    let categoryCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CategoryViewModel> { listCell, indexPath, categoryViewModel in
      var content = UIListContentConfiguration.cell()
      content.text = categoryViewModel.name
      content.image = UIImage(systemName: categoryViewModel.systemIconName)
      listCell.contentConfiguration = content
      listCell.accessories = [.outlineDisclosure()]
    }
    
    let restauranteCellRegistration = UICollectionView.CellRegistration<RestaurantCollectionViewCell, RestaurantViewModel> { cell, _, restaurantViewModel in
      cell.update(with: restaurantViewModel)
      cell.accessories = restaurantViewModel.hasRatings ? [.outlineDisclosure()] : []
    }
    
    let ratingCellRegistration = UICollectionView.CellRegistration<RateCollectionViewCell, RatingViewModel> { cell, _, ratingViewModel in
      cell.update(with: ratingViewModel)
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
      switch item {
      case .category(let categoryViewModel):
        return collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistration, for: indexPath, item: categoryViewModel)
      case .restaurant(let restaurantViewModel):
        return collectionView.dequeueConfiguredReusableCell(using: restauranteCellRegistration, for: indexPath, item: restaurantViewModel)
      case .rating(let ratingViewModel):
        return collectionView.dequeueConfiguredReusableCell(using: ratingCellRegistration, for: indexPath, item: ratingViewModel)
      }
    }
  }
  
  func presentRateView(for restaurantViewModel: RestaurantViewModel) {
    DispatchQueue.main.async {
      let rateWidth = self.view.bounds.width * 0.8
      let rateHeight = rateWidth * 0.6
      let center = self.view.center
      let rateView = RateView(frame: CGRect(x: center.x - rateWidth / 2, y: center.y - rateHeight / 2, width: rateWidth, height: rateHeight))
      rateView.delegate = self
      self.view.addSubview(rateView)
      self.rateView = rateView
      self.idOfRestaurantBeingRated = restaurantViewModel.id
    }
  }
  
  func updateUI(with items: [RowItem]) {
    var snapshot = NSDiffableDataSourceSectionSnapshot<Item>()
    items.forEach { update(snapshot: &snapshot, with: $0, parent: nil) }
    dataSource.apply(snapshot, to: .first)
  }
  
  func update(snapshot: inout NSDiffableDataSourceSectionSnapshot<Item>, with rowItem: RowItem, parent: Item?) {
    snapshot.append([rowItem.item], to: parent)
    rowItem.children.forEach { update(snapshot: &snapshot, with: $0, parent: rowItem.item) }
  }
  
  func getShareableAction(for restaurant: RestaurantViewModel) -> UIAction {
    return UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), identifier: nil) { [weak self] _ in
      let items = self?.viewModel.getShareableItems(for: restaurant.id) ?? []
      self?.present(UIActivityViewController(activityItems: items, applicationActivities: nil), animated: true, completion: nil)
    }
  }
  
  func getRateAction(for restaurant: RestaurantViewModel) -> UIAction {
    return UIAction(title: "Rate", image: UIImage(systemName: "star.fill"), identifier: nil) { [weak self] _ in
      self?.idOfRestaurantBeingRated = restaurant.id
      self?.presentRateView(for: restaurant)
    }
  }
}

extension CategoriesViewController: RateViewDelegate {
  func didTapCancel() {
    rateView?.removeFromSuperview()
  }
  
  func didRate(score: Int, comment: String) {
    rateView?.removeFromSuperview()
    guard let restaurantID = idOfRestaurantBeingRated else { return }
    viewModel.rateRestaurant(restaurantID: restaurantID, score: score, comment: comment)
  }
}

extension CategoriesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard
      case let .restaurant(restaurantViewModel) = dataSource?.itemIdentifier(for: indexPath),
      let restaurant = viewModel.getRestaurant(for: restaurantViewModel.id),
      let restaurantController = RestaurantDetailViewController.getController(for: restaurant)
    else { return }
    navigationController?.show(restaurantController, sender: self)
  }
  
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    guard case let .restaurant(restaurantViewModel) = dataSource?.itemIdentifier(for: indexPath) else { return nil }
    return UIContextMenuConfiguration(
      identifier: nil,
      previewProvider: { [weak self] in
        guard
          let self = self,
          let restaurant = self.viewModel.getRestaurant(for: restaurantViewModel.id),
          let controller = RestaurantDetailViewController.getController(for: restaurant)
        else { return nil }
        return controller
      }, actionProvider: { _ in
        let items: [UIMenuElement] = [
          self.getShareableAction(for: restaurantViewModel),
          self.getRateAction(for: restaurantViewModel)
        ]
        return UIMenu(title: restaurantViewModel.name, children: items)
      })
  }
}
