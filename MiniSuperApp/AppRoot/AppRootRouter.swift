import ModernRIBs

protocol AppRootInteractable: Interactable,
                              AppHomeListener,
                              FinanceHomeListener,
                              ProfileHomeListener {
  var router: AppRootRouting? { get set }
  var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
  func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
  
  private let appHome: AppHomeBuildable
  private let financeHome: FinanceHomeBuildable
  private let profileHome: ProfileHomeBuildable
  
  private var appHomeRouting: ViewableRouting?
  private var financeHomeRouting: ViewableRouting?
  private var profileHomeRouting: ViewableRouting?
  
  init(
    interactor: AppRootInteractable,
    viewController: AppRootViewControllable,
    appHome: AppHomeBuildable,
    financeHome: FinanceHomeBuildable,
    profileHome: ProfileHomeBuildable
  ) {
    self.appHome = appHome
    self.financeHome = financeHome
    self.profileHome = profileHome
    
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  // 자식 Builder의 build 메소드를 통해 router를 전달받아 Riblet을 attach한다.
  func attachTabs() {
    let appHomeRouting = appHome.build(withListener: interactor)
    let financeHomeRouting = financeHome.build(withListener: interactor)
    let profileHomeRouting = profileHome.build(withListener: interactor)

    // attach 되면서 각 Riblet interactor 내부에 didBecomeActive가 실행된다.
    attachChild(appHomeRouting)
    attachChild(financeHomeRouting)
    attachChild(profileHomeRouting)

    let viewControllers = [
      NavigationControllerable(root: appHomeRouting.viewControllable),
      NavigationControllerable(root: financeHomeRouting.viewControllable),
      profileHomeRouting.viewControllable
    ]
    
    viewController.setViewControllers(viewControllers)
  }
}
