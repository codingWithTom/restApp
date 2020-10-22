//
//  ScoreView.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-10-21.
//

import UIKit

final class ScoreView: UIView {
  var score: Int = 0 {
    didSet {
      updateScore()
    }
  }
  private var images: [UIImageView] = []
  private let filledStarName = "star.fill"
  private let emptyStarName = "star"
  private let goldColor = UIColor(red: 212.0 / 256.0, green: 175.0 / 256.0, blue: 55.0 / 256.0, alpha: 1.0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
}

private extension ScoreView {
  func setup() {
    backgroundColor = .clear
    setupViews()
  }
  
  func setupViews() {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .leading
    (0 ..< 5).forEach { _ in
      let imageView = UIImageView()
      imageView.tintColor = goldColor
      imageView.image = UIImage(systemName: emptyStarName)
      images.append(imageView)
      stackView.addArrangedSubview(imageView)
    }
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func updateScore() {
    for index in 0 ..< min(score, images.count) {
      images[index].image = UIImage(systemName: filledStarName)
    }
    
    for index in score ..< images.count {
      images[index].image = UIImage(systemName: emptyStarName)
    }
  }
}
