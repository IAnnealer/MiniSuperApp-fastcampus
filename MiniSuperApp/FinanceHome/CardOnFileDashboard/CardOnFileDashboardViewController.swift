//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/24.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController,
                                                CardOnFileDashboardPresentable,
                                                CardOnFileDashboardViewControllable {
  
  weak var listener: CardOnFileDashboardPresentableListener?
  
  private let headerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    label.text = "카드 및 계좌"
    return label
  }()

  private let cardOnFileStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    stackView.spacing = 12
    return stackView
  }()
  
  private lazy var seeAllButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("전체보기", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.addTarget(self, action: #selector(seeAllButtonTap), for: .touchUpInside)
    return button
  }()

  private lazy var addMethodButton: AddPaymentMethodButton = {
    let button = AddPaymentMethodButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.roundCorners()
    button.backgroundColor = .systemGray4
    button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    return button
  }()

  init() {
    super.init(nibName: nil, bundle: nil)

    setupViews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    setupViews()
  }

  func update(with viewModels: [PaymentMethodViewModel]) {
    cardOnFileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    let views = viewModels.map(PaymentMethodView.init)
    views.forEach {
      $0.roundCorners()
      cardOnFileStackView.addArrangedSubview($0)
    }

    cardOnFileStackView.addArrangedSubview(addMethodButton)

    let heightConstraints = views.map { $0.heightAnchor.constraint(equalToConstant: 50) }
    NSLayoutConstraint.activate(heightConstraints)
  }

  private func setupViews() {
    view.addSubview(headerStackView)
    view.addSubview(cardOnFileStackView)

    headerStackView.addArrangedSubview(titleLabel)
    headerStackView.addArrangedSubview(seeAllButton)

    NSLayoutConstraint.activate([
      headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
      headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      cardOnFileStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
      cardOnFileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      cardOnFileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      cardOnFileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      addMethodButton.heightAnchor.constraint(equalToConstant: 50),
    ])
  }
  
  @objc
  private func seeAllButtonTap() {
  }

  @objc
  private func addButtonDidTap() {

  }
}
