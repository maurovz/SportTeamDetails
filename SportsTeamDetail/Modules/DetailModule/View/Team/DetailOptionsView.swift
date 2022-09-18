import UIKit

protocol DetailOptionsProtocol {
  func didSelectSquads()
  func didSelectOther()
}

final class DetailOptionsView: UIView {
  private let theme: Theme

  var delegate: DetailOptionsProtocol

  var overViewButton: UIButton = {
    let button = UIButton()
    button.setTitle("Overview", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

    return button
  }()

  var matchesButton: UIButton = {
    let button = UIButton()
    button.setTitle("Matches", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    return button
  }()

  var groupsButton: UIButton = {
    let button = UIButton()
    button.setTitle("Groups", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    return button
  }()

  var statsButton: UIButton = {
    let button = UIButton()
    button.setTitle("Stats", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    return button
  }()

  var squadButton: UIButton = {
    let button = UIButton()
    button.setTitle("Squad", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    return button
  }()

  var currentlySelected: UIButton

  init(delegate: DetailOptionsProtocol, theme: Theme) {
    self.delegate = delegate
    self.theme = theme
    self.currentlySelected = squadButton
    super.init(frame: .zero)

    setupView()
    setupButtons()
    backgroundColor = theme.secondaryBackgroundColor
  }

  @available(*,unavailable)
  required init?(coder: NSCoder) {
    nil
  }
}

// MARK: Private functions

private extension DetailOptionsView {
  @objc func squadsSelected(sender: UIButton) {
    setSelectedButton(sender: sender)
    delegate.didSelectSquads()
  }

  @objc func othersSelected(sender: UIButton) {
    setSelectedButton(sender: sender)
    delegate.didSelectOther()
  }

  func setSelectedButton(sender: UIButton) {
    currentlySelected.setTitleColor(theme.secondaryFontColor, for: .normal)
    currentlySelected = sender
    currentlySelected.setTitleColor(theme.selectionTextColor, for: .normal)
  }

  func setupButtons() {
    overViewButton.setTitleColor(theme.secondaryFontColor, for: .normal)
    matchesButton.setTitleColor(theme.secondaryFontColor, for: .normal)
    groupsButton.setTitleColor(theme.secondaryFontColor, for: .normal)
    statsButton.setTitleColor(theme.secondaryFontColor, for: .normal)
    squadButton.setTitleColor(theme.selectionTextColor, for: .normal)

    overViewButton.addTarget(self, action:#selector(self.othersSelected), for: .touchUpInside)
    matchesButton.addTarget(self, action:#selector(self.othersSelected), for: .touchUpInside)
    groupsButton.addTarget(self, action:#selector(self.othersSelected), for: .touchUpInside)
    statsButton.addTarget(self, action:#selector(self.othersSelected), for: .touchUpInside)
    squadButton.addTarget(self, action:#selector(self.squadsSelected), for: .touchUpInside)
  }

  func setupView() {
    let stackView = UIStackView.create(orientation: .horizontal, subviews: [overViewButton, matchesButton, groupsButton, statsButton, squadButton])
    stackView.distribution = .equalSpacing

    addSubview(stackView)
    stackView.anchor(
      top: topAnchor,
      left: leadingAnchor,
      paddingLeft: 20,
      bottom: bottomAnchor,
      right: trailingAnchor,
      paddingRight: 20
    )
  }
}
