import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
  func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable,
                                FinanceHomeViewControllable>,
                                FinanceHomeRouting {

  // 자식 Riblet을 생성하기 위한 Builder를 주입받는다.
  private let superPayDashboardBuildable: SuperPayDashboardBuildable
  private var superPayRouting: Routing?

  // TODO: Constructor inject child builder protocols to allow building children.
  init(
    interactor: FinanceHomeInteractable,
    viewController: FinanceHomeViewControllable,
    superPayDashboardBuildable: SuperPayDashboardBuildable
  ) {
    self.superPayDashboardBuildable = superPayDashboardBuildable
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  // Interactor - didBecomeActive에서 호출.
  // 자식 Riblet 붙이기.
  func attachSuperPayDashboard() {
    if superPayRouting != nil {
      return
    }
    let router = superPayDashboardBuildable.build(withListener: interactor)

    let dashboard = router.viewControllable
    viewController.addDashboard(dashboard)

    self.superPayRouting = router
    attachChild(router)
  }
}
