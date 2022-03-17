import ModernRIBs

protocol AppHomeRouting: ViewableRouting {
  func attachTransportHome()
  func detachTransportHome()
}

protocol AppHomePresentable: Presentable {
  var listener: AppHomePresentableListener? { get set }

  func updateWidget(_ viewModels: [HomeWidgetViewModel])
}

public protocol AppHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
  // 부모 Riblet에 이벤트를 전달할때 사용되며 익숙한 Delegate 패턴을 사용한다.
}

final class AppHomeInteractor: PresentableInteractor<AppHomePresentable>, AppHomeInteractable, AppHomePresentableListener {

  weak var router: AppHomeRouting?
  weak var listener: AppHomeListener?

  override init(presenter: AppHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()

    let viewModels = [
      HomeWidgetModel(
        imageName: "car",
        title: "슈퍼택시",
        tapHandler: { [weak self] in
          self?.router?.attachTransportHome()
        }
      ),
      HomeWidgetModel(
        imageName: "cart",
        title: "슈퍼마트",
        tapHandler: { }
      )
    ]

    presenter.updateWidget(viewModels.map(HomeWidgetViewModel.init))
  }

  func transportHomeDidTapClose() {
    router?.detachTransportHome()
  }

}
