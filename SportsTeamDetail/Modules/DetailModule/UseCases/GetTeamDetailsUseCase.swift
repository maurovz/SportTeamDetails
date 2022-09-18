import UIKit

protocol GetTeamDetailsUseCaseProtocol {
  func getTeam(completion: @escaping (Result<Team, Error>) -> Void)
}

final class GetTeamDetailsUseCase: GetTeamDetailsUseCaseProtocol {
  func getTeam(completion: @escaping (Result<Team, Error>) -> Void) {
    RepositoryFallbackStrategy().fetchData { result in
      switch result {
      case .success(let team):
        completion(.success(team))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

protocol Repository {
  func fetchData(completion: @escaping (Result<Team, Error>) -> Void)
}

// This class helps demonstrate a production fallback scenerio
// where we fetch local data in case of connection issues
final class RepositoryFallbackStrategy: Repository {
  func fetchData(completion: @escaping (Result<Team, Error>) -> Void) {
    RemoteRepo().fetchData { result in
      switch result {
      case .success:
        completion(result)
      case .failure( _):
        // fallback to local if remote fails
        LocalRepo().fetchData { result in
          completion(result)
        }
      }
    }
  }
}

// fetch saved local team data
final class LocalRepo: Repository {
  func fetchData(completion: @escaping (Result<Team, Error>) -> Void) {

    // hardcoded data for demo purposes
    // real life scenario could involve fetching from CoreData, Realm etc...
    let playerImage = UIImage(named: "player")!
    let team = Team(
      squads: [
        Squad(name: "Goalkeepers",
              player: [
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage)
              ]),
        Squad(name: "Defenders",
              player: [
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage)
              ]),
        Squad(name: "Midfildiers",
              player: [
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage)
              ]),
        Squad(name: "Forwards",
              player: [
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage),
                Player(name: "Player name", country: "Argentina", score: "50", image: playerImage)
              ]),
        Squad(name: "Coach", player: [Player(name: "Player name", country: "Argentina", score: "50", image: playerImage)])
      ])
    completion(.success(team))
  }
}

// fetch remote team data from an API
final class RemoteRepo: Repository {
  func fetchData(completion: @escaping (Result<Team, Error>) -> Void) {
    // Automatic failure for demo porpuses
    completion(.failure(ResponseError.connectionError))
  }
}

enum ResponseError: Error {
  case connectionError
}
