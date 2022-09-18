import UIKit

final class GetTeamDetailsUseCase {
  func getTeam(completion: @escaping (Team) -> Void) {
    RepositoryFallbackStrategy().fetchData { result in
      switch result {
      case .success(let team):
        completion(team)
      case .failure(_):
        completion(.init(squads: []))
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
    let team = Team(
      squads: [
        Squad(name: "Defense",
              player: [
                Player(name: "Messy", image: UIImage(named: "player")!),
                Player(name: "Messy", image: UIImage(named: "player")!),
                Player(name: "Messy", image: UIImage(named: "player")!),
                Player(name: "Messy", image: UIImage(named: "player")!)
              ]),
        Squad(name: "Defense", player: [Player(name: "Messy", image: UIImage(named: "player")!)]),
        Squad(name: "Defense", player: [Player(name: "Messy", image: UIImage(named: "player")!)]),
        Squad(name: "Defense", player: [Player(name: "Messy", image: UIImage(named: "player")!)])
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
