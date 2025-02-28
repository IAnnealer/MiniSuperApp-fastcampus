//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/24.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
  var listener: CardOnFileDashboardPresentableListener? { get set }

  func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol CardOnFileInteractorDependency {
  var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

  weak var router: CardOnFileDashboardRouting?
  weak var listener: CardOnFileDashboardListener?

  private let dependency: CardOnFileInteractorDependency
  private var cancellables: Set<AnyCancellable>

  init(
    presenter: CardOnFileDashboardPresentable,
    dependency: CardOnFileInteractorDependency
  ) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.

    dependency.cardOnFileRepository.cardOnFile
      .sink { methods in
        let viewModels = methods.prefix(5).map { PaymentMethodViewModel($0) }
        self.presenter.update(with: viewModels)
      }.store(in: &cancellables)
  }

  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.

    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }
}
