import UIKit

final class HomeView: UIView {
  var uclSelectionAction: (() -> Void)?
  var uelSelectionAction: (() -> Void)?

  var uclButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.gray, for: .normal)
    button.setTitle("UCL", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)

    return button
  }()

  var uelButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.gray, for: .normal)
    button.setTitle("UEL", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
    return button
  }()

  convenience init() {
    self.init(frame: CGRect.zero)
    setupView()
    setButtons()
  }

  private func setupView() {
    let stackView = UIStackView.create(orientation: .horizontal, subviews: [uclButton, uelButton])
    stackView.distribution = .fillEqually
    stackView.backgroundColor = UIColor(red: 0.082, green: 0.082, blue: 0.451, alpha: 1)

    addSubview(stackView)
    stackView.anchor(
      top: topAnchor,
      paddingTop: 100,
      left: leadingAnchor,
      bottom: bottomAnchor,
      paddingBottom: 50,
      right: trailingAnchor
    )
  }

  private func setButtons() {
    uclButton.addTarget(self, action:#selector(self.uclAction), for: .touchUpInside)
    uelButton.addTarget(self, action:#selector(self.uelAction), for: .touchUpInside)
  }

  @objc func uclAction(sender: UIButton) {
    uclSelectionAction?()
  }

  @objc func uelAction(sender: UIButton) {
    uelSelectionAction?()
  }
}
