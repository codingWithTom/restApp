//
//  RateCollectionViewCell.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-10-21.
//

import UIKit

private extension UIConfigurationStateCustomKey {
  static let ratingViewModel = UIConfigurationStateCustomKey("com.codingWithTom.RatingCollectionViewCell.ratingViewModel")
}

private extension UICellConfigurationState {
  var viewModel: RatingViewModel? {
    set { self[.ratingViewModel] = newValue }
    get { return self[.ratingViewModel] as? RatingViewModel }
  }
}

class RatingCell: UICollectionViewListCell {
  private var viewModel: RatingViewModel?
  
  func update(with viewModel: RatingViewModel) {
    self.viewModel = viewModel
    setNeedsUpdateConfiguration()
  }
  
  override var configurationState: UICellConfigurationState {
    var state = super.configurationState
    state.viewModel = viewModel
    return state
  }
}

final class RateCollectionViewCell: RatingCell {
  private var scoreView = ScoreView()
  private var commentTextView = UITextView()
  
  override func updateConfiguration(using state: UICellConfigurationState) {
    if contentView.subviews.isEmpty { configureView() }
    guard let viewModel = state.viewModel else { return }
    scoreView.score = viewModel.score
    commentTextView.text = viewModel.comment
  }
  
}

private extension RateCollectionViewCell {
  func configureView() {
    commentTextView.isEditable = false
    commentTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
    scoreView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    let stackView = UIStackView(arrangedSubviews: [scoreView, commentTextView])
    stackView.axis = .vertical
    stackView.alignment = .leading
    contentView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    commentTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
      stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
      commentTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
    ])
  }
}
