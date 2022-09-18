import UIKit

final class HomeViewController: UIViewController {
  private let homeView = HomeView()

  public init(uclSelectionAction: @escaping () -> Void, uelSelectionAction: @escaping () -> Void) {
    super.init(nibName: nil, bundle: Bundle(for: HomeViewController.self))
  }

  @available(*,unavailable)
  public required init?(coder: NSCoder) {
    nil
  }

  public override func loadView() {
    view = homeView
  }
}
