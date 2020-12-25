//
//  RestaurantDetailViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
  struct Dependencies {
    var notificationPresentation: NotificationPresentation = NotificationPresentationAdapter()
  }
  @IBOutlet private weak var restaurantImageView: UIImageView!
  @IBOutlet private weak var restaurantDescriptionLabel: UILabel!
  @IBOutlet private weak var restaurantCollectionView: UICollectionView!
  @IBOutlet private weak var imagesCollectionView: UICollectionView!
  private var viewModel: RestaurantDetailViewModel?
  private var dataSource: UICollectionViewDiffableDataSource<Section, RatingViewModel>?
  private var imageDataSource: UICollectionViewDiffableDataSource<Section, ImageViewModel>?
  private var isShowingRatings: Bool = true {
    didSet {
      restaurantCollectionView.isHidden = !isShowingRatings
      imagesCollectionView.isHidden = isShowingRatings
    }
  }
  var dependencies = Dependencies()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureCollectionView()
    configureImagesCollectionView()
    updateDataSource()
    updateImagesDataSource()
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
  
  @IBAction private func didSelectSegment(_ sender: UISegmentedControl) {
    isShowingRatings = sender.selectedSegmentIndex == 0
  }
  
  @IBAction private func didSelectSchedule(_ sender: Any?) {
    viewModel?.userDidTapSchedule { [weak self] isNotificationAllowed in
      if !isNotificationAllowed {
        guard let self = self else { return }
        self.dependencies.notificationPresentation.promptUserForNotificationSettings(from: self)
      }
    }
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
  
  func configureImagesCollectionView() {
    let layout = UICollectionViewCompositionalLayout { section, environment in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.49), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.interItemSpacing = .flexible(0)
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 8.0
      return section
    }
    imagesCollectionView.collectionViewLayout = layout
    configureImagesDataSource()
  }
  
  func configureImagesDataSource() {
    let imageCellRegistration = UICollectionView.CellRegistration<ImageCollectionViewCell, ImageViewModel> { cell, _, imageViewModel in
      cell.configure(with: imageViewModel)
    }
    
    imageDataSource = UICollectionViewDiffableDataSource<Section, ImageViewModel>(collectionView: imagesCollectionView) { collectionView, indexPath, imageViewModl in
      return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: imageViewModl)
    }
  }
  
  func updateDataSource() {
    var snapshot = NSDiffableDataSourceSectionSnapshot<RatingViewModel>()
    snapshot.append(viewModel?.getRatingItems() ?? [])
    dataSource?.apply(snapshot, to: .first)
  }
  
  func updateImagesDataSource() {
    var snapshot = NSDiffableDataSourceSectionSnapshot<ImageViewModel>()
    snapshot.append(viewModel?.getImageItems() ?? [])
    imageDataSource?.apply(snapshot, to: .first)
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
