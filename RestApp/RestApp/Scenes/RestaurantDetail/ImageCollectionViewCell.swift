//
//  ImageCollectionViewCell.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-14.
//

import UIKit

struct ImageViewModel: Hashable {
  let imageURL: String
  let placeHolderImageName: String
  let imageLoading: ((@escaping (UIImage?) -> Void) -> Void)
  
  static func ==(lhs: ImageViewModel, rhs: ImageViewModel) -> Bool {
    return lhs.imageURL == rhs.imageURL
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(imageURL)
    hasher.combine(placeHolderImageName)
  }
}

private extension UIConfigurationStateCustomKey {
  static let viewModel = UIConfigurationStateCustomKey("com.CodingWithTom.RestApp.imageViewModel")
}

private extension UIConfigurationState {
  var viewModel: ImageViewModel? {
    set { self[.viewModel] = newValue }
    get { self[.viewModel] as? ImageViewModel }
  }
}

class ImageCell: UICollectionViewCell {
  private var viewModel: ImageViewModel?
  
  override var configurationState: UICellConfigurationState {
    var state = super.configurationState
    state.viewModel = viewModel
    return state
  }
  
  func configure(with viewModel: ImageViewModel) {
    self.viewModel = viewModel
    setNeedsUpdateConfiguration()
  }
}

final class ImageCollectionViewCell: ImageCell {
  private var restaurantImageImageView = UIImageView()
  private var imageURL: String?
  
  override func updateConfiguration(using state: UICellConfigurationState) {
    if contentView.subviews.isEmpty { configureView() }
    guard
      let viewModel = state.viewModel,
      viewModel.imageURL != imageURL
    else { return }
    imageURL = viewModel.imageURL
    loadImage(with: viewModel)
  }
}

private extension ImageCollectionViewCell {
  func configureView() {
    contentView.addSubview(restaurantImageImageView)
    restaurantImageImageView.translatesAutoresizingMaskIntoConstraints = false
    restaurantImageImageView.contentMode = .scaleAspectFill
    restaurantImageImageView.clipsToBounds = true
    NSLayoutConstraint.activate([
      restaurantImageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      restaurantImageImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      restaurantImageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      restaurantImageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  func loadImage(with viewModel: ImageViewModel) {
    restaurantImageImageView.image = UIImage(named: viewModel.placeHolderImageName)
    viewModel.imageLoading({ [weak self] loadedImage in
      guard
        self?.imageURL == viewModel.imageURL,
        let image = loadedImage
      else { return }
      DispatchQueue.main.async {
        self?.restaurantImageImageView.image = image
      }
    })
  }
}
