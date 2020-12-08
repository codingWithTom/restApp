//
//  RestaurantCollectionViewCell.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-30.
//

import UIKit

private extension UIConfigurationStateCustomKey {
  static let restaurantViewModel = UIConfigurationStateCustomKey("com.codingWithTom.RestaurantCollectionViewCell.restaurantViewModel")
}

private extension UICellConfigurationState {
  var viewModel: RestaurantViewModel? {
    set { self[.restaurantViewModel] = newValue }
    get { return self[.restaurantViewModel] as? RestaurantViewModel }
  }
}

class RestaurantCell: UICollectionViewListCell {
  private var viewModel: RestaurantViewModel? = nil
  
  override var configurationState: UICellConfigurationState {
    var state = super.configurationState
    state.viewModel = self.viewModel
    return state
  }
  
  func update(with viewModel: RestaurantViewModel) {
    self.viewModel = viewModel
    setNeedsUpdateConfiguration()
  }
}

final class RestaurantCollectionViewCell: RestaurantCell {
  private var restaurantImageView = UIImageView()
  private var nameLabel = UILabel()
  private var descriptionLabel = UILabel()
  private var dishLabelsStack = UIStackView()
  
  override func updateConfiguration(using state: UICellConfigurationState) {
    guard let viewModel = state.viewModel else { return }
    if contentView.subviews.isEmpty { setupViews() }
    restaurantImageView.image = UIImage(named: viewModel.imageName)
    nameLabel.text = viewModel.name
    descriptionLabel.text = viewModel.description
    dishLabelsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    viewModel.labels.forEach {
      let label =  UILabel()
      label.text = $0.text
      label.backgroundColor = $0.color
      label.textColor = .white
      label.font = UIFont.boldSystemFont(ofSize: 12)
      dishLabelsStack.addArrangedSubview(label)
    }
  }
}

private extension RestaurantCollectionViewCell {
  func setupViews() {
    let labelStackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
    nameLabel.numberOfLines = 0
    nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    descriptionLabel.numberOfLines = 0
    labelStackView.axis = .vertical
    labelStackView.spacing = 24.0
    labelStackView.alignment = .top
    let stackView = UIStackView(arrangedSubviews: [restaurantImageView, labelStackView])
    stackView.axis = .horizontal
    stackView.spacing = 8.0
    dishLabelsStack.axis = .horizontal
    dishLabelsStack.spacing = 4.0
    contentView.addSubview(stackView)
    contentView.addSubview(dishLabelsStack)
    dishLabelsStack.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
      restaurantImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
      restaurantImageView.heightAnchor.constraint(equalTo: restaurantImageView.widthAnchor),
      dishLabelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      dishLabelsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0)
    ])
  }
}
