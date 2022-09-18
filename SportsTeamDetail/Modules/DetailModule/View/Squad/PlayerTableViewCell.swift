import UIKit

class PlayerTableViewCell: UITableViewCell {
  let playerImage = UIImageView()
  let playerName = UILabel()
  let playerCountry = UILabel()
  let scoreLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    textLabel?.textColor = .white

    setupPlayerImage()
    setupPlayerLabels()
    setupScoreLabel()
  }

  @available(*,unavailable)
  required init?(coder: NSCoder) {
    nil
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel?.text = ""
    playerImage.image = nil
    playerName.text = ""
    playerCountry.text = ""
    scoreLabel.text = ""
  }
}

private extension PlayerTableViewCell {
  func setupPlayerImage() {
    let imageSize: CGFloat = 41

    playerImage.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(playerImage)

    NSLayoutConstraint.activate([
      playerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      NSLayoutConstraint(item: playerImage, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
      playerImage.heightAnchor.constraint(equalToConstant: imageSize),
      playerImage.widthAnchor.constraint(equalToConstant: imageSize)
    ])
    playerImage.layer.cornerRadius = imageSize / 2
    playerImage.clipsToBounds = true

    playerName.font = UIFont.systemFont(ofSize: 15)
    playerName.textColor = .white
    playerCountry.font = UIFont.systemFont(ofSize: 12)
    playerCountry.textColor = .white
  }

  func setupPlayerLabels() {
    let stackView = UIStackView.create(orientation: .vertical, subviews: [playerName, playerCountry])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .leading
    contentView.addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 20),
      NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
    ])
  }

  func setupScoreLabel() {
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textColor = .white
    contentView.addSubview(scoreLabel)

    NSLayoutConstraint.activate([
      scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      NSLayoutConstraint(item: scoreLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
    ])
  }
}
