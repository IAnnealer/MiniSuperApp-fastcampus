//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/02/28.
//

import ModernRIBs
import Combine
import Foundation

protocol SuperPayDashboardRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

// ViewCOntroller에서 conform하는 프로토콜.
protocol SuperPayDashboardPresentable: Presentable {
  var listener: SuperPayDashboardPresentableListener? { get set }

  func updateBalance(_ balance: String)
}

protocol SuperPayDashboardListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

// Interator 비즈니스 로직 수행을 위해 필요한 Dependency
// SuperPayDashbaord의 경우 잔액을 받아온다.
protocol SuperPayDashboardInteractorDependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
  var balanceFormatter: NumberFormatter { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

  weak var router: SuperPayDashboardRouting?
  weak var listener: SuperPayDashboardListener?

  private let dependency: SuperPayDashboardInteractorDependency

  private var cancellables: Set<AnyCancellable>

  init(
    presenter: SuperPayDashboardPresentable,
    dependency: SuperPayDashboardInteractorDependency
    // 생성자를 통해 의존성 주입시 프로토콜을 통해 주입받으면 추후 변경사항이 생겨도 고쳐야 할 곳이 줄어든다.
  ) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()

    dependency.balance
      .sink { [weak self] balance in
        self?.dependency.balanceFormatter.string(from: NSNumber(value: balance)).map {
          self?.presenter.updateBalance($0)
        }
      }
      .store(in: &cancellables)
  }

  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
}
