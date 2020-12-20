//
//  SidebarViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-13.
//

import UIKit
import Combine

class SidebarViewController: UIViewController {
  
  enum SidebarSection: Int {
    case browse, favorites
  }
  
  enum SidebarRowType: Int {
    case header, row, favorite
  }
  
  struct SidebarItem: Hashable {
    let title: String
    let image: UIImage?
    let type: SidebarRowType
    var restaurantID: String? = nil
  }
  
  private var collectionView: UICollectionView!
  private var datasource: UICollectionViewDiffableDataSource<SidebarSection, SidebarItem>?
  private var favoritesSubscriber: AnyCancellable?
  private let viewModel = SidebarViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureCollection()
    updateDatasource()
    favoritesSubscriber = viewModel.favorites.receive(on: RunLoop.main).sink { [weak self] in
      guard let self = self else { return }
      self.datasource?.apply(self.favoritesSnapsho(favorites: $0), to: .favorites, animatingDifferences: true)
    }
  }
}

extension SidebarViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      if indexPath.row == 1, let categoriesController = CategoriesViewController.instantiateFromStoryboard() {
        if let nav = splitViewController?.viewController(for: .supplementary) as? UINavigationController,
           let _ = nav.viewControllers.first  as? CategoriesViewController {
          return
        }
        splitViewController?.setViewController(UINavigationController(rootViewController: categoriesController), for: .supplementary)
      } else if indexPath.row == 2, let profileController = ProfileViewController.instantiateFromStoryboard() {
        if let nav = splitViewController?.viewController(for: .supplementary) as? UINavigationController,
           let _ = nav.viewControllers.first  as? ProfileViewController {
          return
        }
        splitViewController?.setViewController(UINavigationController(rootViewController: profileController), for: .secondary)
        splitViewController?.preferredDisplayMode = .secondaryOnly
      }
    } else if indexPath.section == 1 {
      guard
        let restaurantID = datasource?.itemIdentifier(for: indexPath)?.restaurantID,
        let restaurant = viewModel.restaurant(for: restaurantID),
        let restaurantController = RestaurantDetailViewController.getController(for: restaurant)
      else { return }
      splitViewController?.setViewController(UINavigationController(rootViewController: restaurantController), for: .secondary)
      UIView.animate(withDuration: 0.4) {
        self.splitViewController?.preferredDisplayMode = .oneBesideSecondary
      }
    }
  }
}

extension SidebarViewController: UICollectionViewDropDelegate {
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    let dragItems = coordinator.items.map { $0.dragItem }.map { $0.itemProvider }
    dragItems.forEach {
      $0.loadObject(ofClass: RestaurantDropItem.self) { [weak self] item, error in
        guard
          error == nil,
          let dropItem = item as? RestaurantDropItem
        else { return }
        self?.viewModel.addFavorite(restaurantDropItem: dropItem)
      }
    }
  }
}

private extension SidebarViewController {
  func configureView() {
    var configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
    configuration.headerMode = .firstItemInSection
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    collectionView.dropDelegate = self
    view.addSubview(collectionView)
  }
  
  func configureCollection() {
    let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SidebarItem> { cell, indexPath, item in
      var configuration = UIListContentConfiguration.sidebarHeader()
      configuration.text = item.title
      cell.contentConfiguration = configuration
      cell.accessories = [.outlineDisclosure()]
    }
    
    let rowCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SidebarItem> { cell, indexPath, item in
      var configuration = UIListContentConfiguration.sidebarCell()
      configuration.text = item.title
      configuration.image = item.image
      cell.contentConfiguration = configuration
    }
    
    let favoriteCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SidebarItem> { cell, indexPath, item in
      var configuration = UIListContentConfiguration.subtitleCell()
      configuration.text = item.title
      configuration.image = item.image
      cell.contentConfiguration = configuration
      let deleteOptions = UICellAccessory.DeleteOptions(isHidden: false, reservedLayoutWidth: .standard, tintColor: .systemRed, backgroundColor: .clear)
      cell.accessories = [.delete(displayed: .always, options: deleteOptions, actionHandler: { [weak self] in
        guard
          let item = self?.datasource?.itemIdentifier(for: indexPath),
          let restaurantID = item.restaurantID
        else { return }
        self?.viewModel.removeFavorite(withID: restaurantID)
      })]
    }
    
    datasource = UICollectionViewDiffableDataSource<SidebarSection, SidebarItem>(collectionView: collectionView) { collectionView, indexPath, item in
      switch item.type {
      case .header: return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: item)
      case .row: return collectionView.dequeueConfiguredReusableCell(using: rowCellRegistration, for: indexPath, item: item)
      case .favorite: return collectionView.dequeueConfiguredReusableCell(using: favoriteCellRegistration, for: indexPath, item: item)
      }
    }
  }
  
  func updateDatasource() {
    datasource?.apply(browseSnapshot(), to: .browse, animatingDifferences: false)
    datasource?.apply(favoritesSnapsho(favorites: []), to: .favorites, animatingDifferences: false)
  }
  
  func browseSnapshot() -> NSDiffableDataSourceSectionSnapshot<SidebarItem> {
    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<SidebarItem>()
    let header = SidebarItem(title: "Browse", image: nil, type: .header)
    sectionSnapshot.append([header])
    sectionSnapshot.append(TabBarItems.allCases.map { SidebarItem(title: $0.title, image: $0.image, type: .row) },
                           to: header)
    sectionSnapshot.expand([header])
    return sectionSnapshot
  }
  
  func favoritesSnapsho(favorites: [RestaurantViewModel]) -> NSDiffableDataSourceSectionSnapshot<SidebarItem> {
    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<SidebarItem>()
    let header = SidebarItem(title: "Favorites", image: nil, type: .header)
    sectionSnapshot.append([header])
    let favoriteImage = UIImage(systemName: "suit.heart")
    sectionSnapshot.append(favorites.map { SidebarItem(title: $0.name, image: favoriteImage, type: .favorite, restaurantID: $0.id) }, to: header)
    if !favorites.isEmpty {
      sectionSnapshot.expand([header])
    }
    return sectionSnapshot
  }
}
