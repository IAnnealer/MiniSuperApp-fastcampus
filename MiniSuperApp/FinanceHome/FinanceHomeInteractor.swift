import ModernRIBs

protocol FinanceHomeRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
  func attachSuperPayDashboard()
}

protocol FinanceHomePresentable: Presentable {
  var listener: FinanceHomePresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FinanceHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

// Interactor: Riblet의 모든 로직 시작점.
final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener {

  weak var router: FinanceHomeRouting?
  weak var listener: FinanceHomeListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: FinanceHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  // FinanceHome의 Riblet이 부모 Riblet에 attach되면 해당 함수가 바로 실행되어 자식 SuperPayDashboard attach
  override func didBecomeActive() {
    super.didBecomeActive()

    router?.attachSuperPayDashboard()
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
}
