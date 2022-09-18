import XCTest
@testable import SportsTeamDetail

class SportsTeamDetailTests: XCTestCase {

  func test_viewDidLoad_beforeUseCaseCompletes_returnsLoadingState() {
    let (sut, _) = makeSUT()

    sut.input.send(.viewDidLoad)

    let receivedValues = CombinePublisherSpy<TeamDetailViewModel.State>(publisher: sut.output.eraseToAnyPublisher()).values

    XCTAssertEqual([.loading], receivedValues)
  }

  func test_viewDidLoad_useCaseCompletesWithSuccess_returnsModel() {
    let (sut, spy) = makeSUT()
    spy.responseStub = .prototype

    sut.input.send(.viewDidLoad)

    let receivedValues = CombinePublisherSpy<TeamDetailViewModel.State>(
      publisher: sut.output.eraseToAnyPublisher())
      .values

    XCTAssertEqual([.didFetchTeam(model: .prototype)], receivedValues)
  }

  func test_viewDidLoad_useCaseCompletesWithError_returnsExpectedError() {
    let (sut, spy) = makeSUT()
    spy.errorStub = .anyError

    sut.input.send(.viewDidLoad)

    let receivedValues = CombinePublisherSpy<TeamDetailViewModel.State>(
      publisher: sut.output.eraseToAnyPublisher())
      .values

    XCTAssertEqual([.didGetError(error: NSError.anyError)], receivedValues)
  }

  private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: TeamDetailViewModel, spy: UseCaseSpy) {
    let spy = UseCaseSpy()
    let sut = TeamDetailViewModel(getTeamDetailsUseCase: spy)

    trackMemoryLeaks(for: spy, sut, file: file, line: line)

    return (sut, spy)
  }
}

// MARK: - Test Doubles
final class UseCaseSpy: GetTeamDetailsUseCaseProtocol {
  var responseStub: Team?
  var errorStub: NSError?

  func getTeam(completion: @escaping (Result<Team, Error>) -> Void) {
    if let responseStub = responseStub {
      completion(.success(responseStub))
    } else if let error = errorStub {
      completion(.failure(error))
    }
  }
}

extension NSError {
  static let anyError = NSError(domain: "any-error", code: .zero)
}

// TeamDetailViewModel.State Equatable helper extension
extension TeamDetailViewModel.State: Equatable {
  public static func == (lhs: SportsTeamDetail.TeamDetailViewModel.State, rhs: SportsTeamDetail.TeamDetailViewModel.State) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading):
      return true
    case (.didFetchTeam(let model1), .didFetchTeam(let model2)):
      return model1 == model2
    case (.didGetError(let error1), didGetError(let error2)):
      return error1 as NSError == error2 as NSError
    default:
      return false
    }
  }
}

extension Team {
  static let prototype = Team(squads: [
    .init(name: "", player: [
      .init(name: "Messi", country: "Argentina", score: "100", image: UIImage()),
      .init(name: "Cristiano Ronaldo", country: "Portugal", score: "99", image: UIImage()),
      .init(name: "Neymar", country: "Brazil", score: "98", image: UIImage())
    ])
  ])
}

// TODO: Move to separate file

import Combine

final class CombinePublisherSpy<T> {

  private(set) var values: [T] = []
  private(set) var errors: [Error] = []
  private(set) var completions: [Subscribers.Completion<Never>] = []
  private var cancellables = Set<AnyCancellable>()

  init(publisher: AnyPublisher<T, Never>) {
    publisher.sink { [weak self] completion in
      self?.completions.append(completion)

      if case let .failure(error) = completion {
        self?.errors.append(error)
      }

    } receiveValue: { [weak self] value in
      self?.values.append(value)
    }.store(in: &cancellables)
  }
}

import XCTest

extension XCTestCase {
  func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.",
                   file: file,
                   line: line)
    }
  }

  func trackMemoryLeaks(for instances: AnyObject..., file: StaticString = #file, line: UInt = #line) {
    for instance in instances {
      trackForMemoryLeaks(instance, file: file, line: line)
    }
  }
}
