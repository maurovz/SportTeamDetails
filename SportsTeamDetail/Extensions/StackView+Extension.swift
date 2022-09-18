import UIKit

extension UIStackView {
  static func create(orientation: NSLayoutConstraint.Axis, subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    stackView.axis = orientation
    return stackView
  }
}
