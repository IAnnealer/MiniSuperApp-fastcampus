import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

// Component: Riblet이 필요한 객체들을 담는 바구니.
// 이 바구니는 자식 Riblet이 필요한 객체들도 함께 담는다.
// 따라서, 자식들의 Dependency도 함꼐 conform 한다.
final class FinanceHomeComponent: Component<FinanceHomeDependency>,
                                  SuperPayDashboardDependency,
                                  CardOnFileDashboardDependency {

  // 자식에게 repository 전달
  let cardOnFileRepository: CardOnFileRepository

  // 자식에게 readOnly 타입의 Stream을 전달
  var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }

  // 잔액 Stream
  private let balancePublisher: CurrentValuePublisher<Double>

  init(
    dependency: FinanceHomeDependency,
    balance: CurrentValuePublisher<Double>,
    cardOnFileRepository: CardOnFileRepository
  ) {
    self.balancePublisher = balance
    self.cardOnFileRepository = cardOnFileRepository
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {

  override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }

  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
    let balancePublisher = CurrentValuePublisher<Double>(10000)

    let component = FinanceHomeComponent(
      dependency: dependency,
      balance: balancePublisher,
      cardOnFileRepository: CardOnFileRepositoryImp()
    )
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener

    // Finance Riblet의 자식 Riblet으로 SuperPayDashboard Riblet을 붙이기 위한 준비.
    let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
    let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)

    return FinanceHomeRouter(
      interactor: interactor,
      viewController: viewController,
      superPayDashboardBuildable: superPayDashboardBuilder,
      cardOnFileDashboardBuildable: cardOnFileDashboardBuilder
    )
  }
}
