import UIKit

final class DetailHeaderView: UIView {
  private let theme: Theme

  private var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    return imageView
  }()

  private var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    return imageView
  }()

  private var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 48)
    label.textAlignment = .left
    return label
  }()

  private var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()

  private var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()

  init(theme: Theme) {
    self.theme = theme
    super.init(frame: .zero)

    setupView()
    configure()
  }

  @available(*,unavailable)
  required init?(coder: NSCoder) {
    nil
  }

  func configure() {
    titleLabel.textColor = theme.primaryFontColor
    subtitleLabel.textColor = theme.secondaryFontColor
    descriptionLabel.textColor = theme.primaryFontColor

    // Text should be pulled from a localized string file
    subtitleLabel.text = "Playing"
    descriptionLabel.text = "Round of 16"
    titleLabel.text = "Barcelona"

    iconImageView.image = UIImage(named: "icon")
    logoImageView.image = UIImage(named: "logo")
  }

  private func setupView() {
    let backgroundImageView = UIImageView(image: theme.headerImage)
    addSubview(backgroundImageView)
    backgroundImageView.anchor(
      top: topAnchor,
      left: self.leadingAnchor,
      paddingLeft: 0,
      right: trailingAnchor,
      height: 330
    )

    addSubview(titleLabel)
    titleLabel.anchor(
      top: layoutMarginsGuide.topAnchor,
      paddingTop: 20,
      left: leadingAnchor,
      paddingLeft: 20
    )

    addSubview(iconImageView)
    iconImageView.anchor(
      top: layoutMarginsGuide.topAnchor,
      right: trailingAnchor,
      paddingRight: 20
    )

    addSubview(logoImageView)
    logoImageView.anchor(
      top: iconImageView.bottomAnchor,
      paddingTop: 70,
      left: titleLabel.trailingAnchor,
      paddingLeft: 20,
      right: trailingAnchor,
      paddingRight: 20
    )

    let textStackView = UIStackView.create(orientation: .vertical, subviews: [subtitleLabel, descriptionLabel])
    textStackView.spacing = 0
    addSubview(textStackView)
    textStackView.anchor(
      left: leadingAnchor,
      paddingLeft: 20,
      bottom: logoImageView.bottomAnchor
    )

    iconImageView.setDimensions(width: 32, height: 32)
    logoImageView.setDimensions(width: 110, height: 110)
  }
}
