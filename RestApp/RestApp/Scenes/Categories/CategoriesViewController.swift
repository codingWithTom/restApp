//
//  CategoriesViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import UIKit

enum Section: Hashable {
  case first
}

enum Item: Hashable {
  case category(CategoryViewModel)
  case restaurant(RestaurantViewModel)
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
}

final class CategoriesViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    RestaurantServiceAdapter.shared.getRestaurants { [weak self] categories in
      DispatchQueue.main.async {
        self?.updateUI(with: categories)
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
    configureDataSource()
  }
  
  func getSwipeConfiguration(for item: Item) -> UISwipeActionsConfiguration? {
    guard case let .restaurant(viewModel) = item else { return nil }
    let rateAction = UIContextualAction(style: .normal, title: "Rate") { _, _, completion in
      print("Rated restaurant \(viewModel.name)")
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
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
      switch item {
      case .category(let categoryViewModel):
        return collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistration, for: indexPath, item: categoryViewModel)
      case .restaurant(let restaurantViewModel):
        return collectionView.dequeueConfiguredReusableCell(using: restauranteCellRegistration, for: indexPath, item: restaurantViewModel)
      }
    }
  }
  
  func updateUI(with categories: [Category]) {
    var snapshot = NSDiffableDataSourceSectionSnapshot<Item>()
    categories.forEach { category in
      let categoryItem = Item.category(category.viewModel)
      snapshot.append([categoryItem])
      snapshot.append(category.restaurants.map { Item.restaurant($0.viewModel) }, to: categoryItem)
    }
    dataSource.apply(snapshot, to: .first)
  }
}

private extension Category {
  var viewModel: CategoryViewModel {
    return CategoryViewModel(name: self.name, systemIconName: self.iconImageName)
  }
}

private extension Restaurant {
  var viewModel: RestaurantViewModel {
    return RestaurantViewModel(id: restaurantID, imageName: imageName, name: name, description: description)
  }
}
