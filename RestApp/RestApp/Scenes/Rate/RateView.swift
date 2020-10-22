//
//  RateView.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-10-21.
//

import UIKit

protocol RateViewDelegate: class {
  func didTapCancel()
  func didRate(score: Int, comment: String)
}

final class RateView: UIView {
  private var stepper = UIStepper()
  private var commentTextView = UITextView()
  private var scoreView = ScoreView()
  private var score = 5 {
    didSet {
      scoreView.score = score
    }
  }
  weak var delegate: RateViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
}

private extension RateView {
  func setup() {
    backgroundColor = .white
    setupBackgroundView()
    setupViews()
  }
  
  func setupViews() {
    let commentStackView = getCommentStackView()
    let buttonStackView = getButtonStackView()
    configureViews()
    let stackView = UIStackView(arrangedSubviews: [scoreView, commentStackView, stepper, buttonStackView])
    stackView.spacing = 8.0
    stackView.axis = .vertical
    stackView.alignment = .center
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
      commentStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
      commentStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4)
    ])
  }
  
  func getCommentStackView() -> UIStackView {
    let commentLabel = UILabel()
    commentLabel.text = "Comment:"
    commentLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    commentTextView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    commentTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
    commentTextView.layer.cornerRadius = 8.0
    commentTextView.layer.borderWidth = 1.0
    commentTextView.layer.borderColor = UIColor.black.cgColor
    let commentStackView = UIStackView(arrangedSubviews: [commentLabel, commentTextView])
    commentStackView.axis = .horizontal
    commentStackView.setContentHuggingPriority(.defaultLow, for: .vertical)
    commentStackView.spacing = 4.0
    return commentStackView
  }
  
  func getButtonStackView() -> UIStackView {
    let cancelButton = UIButton()
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.setTitleColor(.blue, for: .normal)
    cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    let rateButton = UIButton()
    rateButton.setTitle("Rate", for: .normal)
    rateButton.setTitleColor(.blue, for: .normal)
    rateButton.addTarget(self, action: #selector(didTapRate), for: .touchUpInside)
    let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, rateButton])
    buttonStackView.axis = .horizontal
    buttonStackView.spacing = 15.0
    return buttonStackView
  }
  
  @objc
  func didTapCancel() {
    delegate?.didTapCancel()
  }
  
  @objc
  func didTapRate() {
    delegate?.didRate(score: scoreView.score, comment: commentTextView.text ?? "")
  }
  
  func configureViews() {
    scoreView.score = score
    scoreView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    stepper.value = Double(score)
    stepper.maximumValue = 5.0
    stepper.minimumValue = 1.0
    stepper.isContinuous = false
    stepper.addTarget(self, action: #selector(stepperChangedValue), for: .valueChanged)
  }
  
  @objc func stepperChangedValue() {
    score = Int(stepper.value)
  }
  
  func setupBackgroundView() {
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    addSubview(backgroundView)
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
