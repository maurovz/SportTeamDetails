import UIKit

struct Team {
  var squads: [Squad]
}

struct Squad {
  let name: String
  let player: [Player]
  var isOpened: Bool = true
}

struct Player {
  let name: String
  let country: String
  let score: String
  let image: UIImage
}
