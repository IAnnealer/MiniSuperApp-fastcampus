//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/24.
//

import UIKit

final class AddPaymentMethodButton: UIControl {

  private let plusIconImageView: UIImageView = {
    let imageView = UIImageView(
      image: UIImage(
        systemName: "plus",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
      )
    )
    imageView.tintColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false

    return imageView
  }()

  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    setupViews()
  }

  private func setupViews() {
    addSubview(plusIconImageView)

    NSLayoutConstraint.activate([
      plusIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      plusIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
