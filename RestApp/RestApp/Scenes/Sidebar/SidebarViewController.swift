//
//  SidebarViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-13.
//

import UIKit

class SidebarViewController: UIViewController {
  
  enum SidebarSection: Int {
    case browse, bookmarks
  }
  
  enum SidebarRowType: Int {
    case header, row
  }
  
  struct SidebarItem: Hashable {
    let title: String
    let image: UIImage?
    let type: SidebarRowType
  }
  
  private var collectionView: UICollectionView!
  private var datasource: UICollectionViewDiffableDataSource<SidebarSection, SidebarItem>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureCollection()
    updateDatasource()
  }
}

extension SidebarViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    datasource = UICollectionViewDiffableDataSource<SidebarSection, SidebarItem>(collectionView: collectionView) { collectionView, indexPath, item in
      switch item.type {
      case .header: return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: item)
      case .row: return collectionView.dequeueConfiguredReusableCell(using: rowCellRegistration, for: indexPath, item: item)
      }
    }
  }
  
  func updateDatasource() {
    datasource?.apply(browseSnapshot(), to: .browse, animatingDifferences: false)
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
}
