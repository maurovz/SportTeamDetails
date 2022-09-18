import UIKit

struct Team: Equatable {
  var squads: [Squad]
}

struct Squad: Equatable {
  let name: String
  let player: [Player]
  var isOpened: Bool = true
}

struct Player: Equatable {
  let name: String
  let country: String
  let score: String
  let image: UIImage
}
