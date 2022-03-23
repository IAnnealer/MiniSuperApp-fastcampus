//
//  SuperPayDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/02/28.
//

import ModernRIBs
import Foundation

/// SupearPayDashboard Riblet이 동작하기 위해 필요한 객체들
protocol SuperPayDashboardDependency: Dependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

// Component는 본인과 자식 RIblet이 필요한 객체들을 담고있는 바구니.
// SuperPayDashboardInteractor의 depedency로 전달된다.
// 따라서 Interactor dependency를 conform한다.
final class SuperPayDashboardComponent: Component<SuperPayDashboardDependency>,
                                          SuperPayDashboardInteractorDependency {
  // 부모로부터 받아와서 전달만 해준다.
  var balance: ReadOnlyCurrentValuePublisher<Double> { dependency.balance }
  var balanceFormatter: NumberFormatter { Formatter.balanceFormatter }
}

// MARK: - Builder

protocol SuperPayDashboardBuildable: Buildable {
  func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting
}

final class SuperPayDashboardBuilder: Builder<SuperPayDashboardDependency>, SuperPayDashboardBuildable {
  
  override init(dependency: SuperPayDashboardDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting {
    let component = SuperPayDashboardComponent(dependency: dependency)
    let viewController = SuperPayDashboardViewController()
    let interactor = SuperPayDashboardInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener
    return SuperPayDashboardRouter(interactor: interactor, viewController: viewController)
  }
}
