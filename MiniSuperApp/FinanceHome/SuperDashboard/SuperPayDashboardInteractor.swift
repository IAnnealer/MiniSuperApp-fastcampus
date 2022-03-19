//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/02/28.
//

import ModernRIBs

protocol SuperPayDashboardRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashboardPresentable: Presentable {
  var listener: SuperPayDashboardPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SuperPayDashboardListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol SuperPayDashboardInteractorDependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

  weak var router: SuperPayDashboardRouting?
  weak var listener: SuperPayDashboardListener?

  private let dependency: SuperPayDashboardInteractorDependency

  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(
    presenter: SuperPayDashboardPresentable,
    dependency: SuperPayDashboardInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }

  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
}
