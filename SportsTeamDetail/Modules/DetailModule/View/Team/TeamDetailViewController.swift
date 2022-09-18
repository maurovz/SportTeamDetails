import UIKit
import Combine

final class TeamDetailViewController: UIViewController {
  private let viewModel: TeamDetailViewModel
  private let teamDetailView: TeamDetailView

  private var cancellables = Set<AnyCancellable>()

  public init(viewModel: TeamDetailViewModel, theme: Theme) {
    self.viewModel = viewModel
    self.teamDetailView = TeamDetailView(theme: theme)
    super.init(nibName: nil, bundle: Bundle(for: TeamDetailViewController.self))
  }

  @available(*,unavailable)
  public required init?(coder: NSCoder) {
    nil
  }

  public override func loadView() {
    view = teamDetailView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    bindOutput()
    viewModel.input.send(.viewDidLoad)
  }

  private func bindOutput() {
    viewModel.output.sink { state in
      switch state {
      case .loading:
        // Here we can show an activity indicator or custom loading animation
        print("Show loading animataion")

      case let .didFetchTeam(model):
        self.teamDetailView.updateTeam(model)

      case let .didGetError(error):
        // Show error alert message
        print("Show \(error) view")
      }
    }.store(in: &cancellables)
  }
}
