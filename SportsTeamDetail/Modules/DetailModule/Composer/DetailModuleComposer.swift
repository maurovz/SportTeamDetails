import UIKit

enum DetailModuleComposer {
  static func makeModule(theme: Theme) -> UIViewController {
    TeamDetailViewController(viewModel: TeamDetailViewModel(getTeamDetailsUseCase: GetTeamDetailsUseCase()), theme: theme)
  }
}
