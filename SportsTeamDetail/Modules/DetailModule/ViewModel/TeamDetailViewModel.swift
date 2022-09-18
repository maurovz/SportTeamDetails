import Combine

final class TeamDetailViewModel {
  // Input events
  enum InputEvents {
    case viewDidLoad
  }

  // State
  enum State {
    case loading
    case didFetchTeam(model: Team)
    case didGetError(error: Error)
  }

  // Inputs & Outputs
  var input = PassthroughSubject<InputEvents, Never>()
  var output = CurrentValueSubject<State, Never>(.loading)

  private var cancellables = Set<AnyCancellable>()
  private let getTeamDetailsUseCase: GetTeamDetailsUseCase

  init(getTeamDetailsUseCase: GetTeamDetailsUseCase) {
    self.getTeamDetailsUseCase = getTeamDetailsUseCase

    bindInput()
  }

  func bindInput() {
    input.sink { [weak self] event in
      guard let self = self else { return }

      switch event {
      case .viewDidLoad:
        self.output.send(.loading)
        self.getTeamDetails()
      }
    }.store(in: &cancellables)
  }

  func getTeamDetails() {
    getTeamDetailsUseCase.getTeam(completion: { [weak self] model in
      guard let self = self else { return }

      self.output.send(.didFetchTeam(model: model))
    })
  }
}