//
//  RestaurantDetailViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
  
  @IBOutlet private weak var restaurantImageView: UIImageView!
  @IBOutlet private weak var restaurantDescriptionLabel: UILabel!
  @IBOutlet private weak var restaurantCollectionView: UICollectionView!
  private var viewModel: RestaurantDetailViewModel?
  private var dataSource: UICollectionViewDiffableDataSource<Section, RatingViewModel>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureCollectionView()
    updateDataSource()
    addActions()
  }
  
  func configure(with restaurant: Restaurant) {
    self.viewModel = RestaurantDetailViewModel(restaurant: restaurant)
  }
  
  static func getController(for restaurant: Restaurant) -> RestaurantDetailViewController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard
      let controller = storyboard.instantiateViewController(identifier: String(describing: RestaurantDetailViewController.self)) as? RestaurantDetailViewController
    else { return nil }
    controller.configure(with: restaurant)
    return controller
  }
}

private extension RestaurantDetailViewController {
  func configureUI() {
    guard let viewModel = self.viewModel else { return }
    restaurantImageView.image = UIImage(named: viewModel.restaurantImageName)
    restaurantDescriptionLabel.text = viewModel.restaurantDescription
    title = viewModel.title
  }
  
  func configureCollectionView() {
    let layout = UICollectionViewCompositionalLayout { section, environment in
      let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
    }
    restaurantCollectionView.collectionViewLayout = layout
    configureDataSource()
  }
  
  func configureDataSource() {
    let ratingCellRegistration = UICollectionView.CellRegistration<RateCollectionViewCell, RatingViewModel> { cell, _, ratingViewModel in
      cell.update(with: ratingViewModel)
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, RatingViewModel> (collectionView: restaurantCollectionView) { collectionView, indexPath, ratingViewModel in
      return collectionView.dequeueConfiguredReusableCell(using: ratingCellRegistration, for: indexPath, item: ratingViewModel)
    }
  }
  
  func updateDataSource() {
    var snapshot = NSDiffableDataSourceSectionSnapshot<RatingViewModel>()
    snapshot.append(viewModel?.getRatingItems() ?? [])
    dataSource?.apply(snapshot, to: .first)
  }
  
  func addActions() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
  }
  
  @objc func didTapShare() {
    let items = viewModel?.getShareableItems() ?? []
    let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    present(activityController, animated: true, completion: nil)
  }
}
