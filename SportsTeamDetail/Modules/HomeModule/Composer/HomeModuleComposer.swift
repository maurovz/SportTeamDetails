import UIKit

public enum HomeModuleComposer {
  // harcoded for demo porpuses. Ideally, theme could
  // be pulled from a remote or local configuration file
  // depending on the app target (if different per target)
  static private let uclTheme = Theme(
    headerImage: UIImage(named: "uclHeader")!,
    primaryBackgroundColor: UIColor(red: 0.039, green: 0.039, blue: 0.38, alpha: 1),
    secondaryBackgroundColor: UIColor(red: 0.082, green: 0.082, blue: 0.451, alpha: 1),
    primaryFontColor: .white,
    secondaryFontColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.7),
    selectionTextColor: UIColor(red: 0.353, green: 0.969, blue: 0.863, alpha: 1),
    dividerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
  )

  static private let uelTheme = Theme(
    headerImage: UIImage(named: "uelHeader")!,
    primaryBackgroundColor: UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1),
    secondaryBackgroundColor: UIColor(red: 0.173, green: 0.173, blue: 0.18, alpha: 1),
    primaryFontColor: .white,
    secondaryFontColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.7),
    selectionTextColor: UIColor(red: 1, green: 0.412, blue: 0, alpha: 1),
    dividerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
  )

  public static func makeModule(navigationController: UINavigationController) -> UIViewController {
    HomeViewController(
      uclSelectionAction: {
        pushDetailModule(navigationController: navigationController, theme: uclTheme)
      },
      uelSelectionAction: {
        pushDetailModule(navigationController: navigationController, theme: uelTheme)
      }
    )
  }

  private static func pushDetailModule(navigationController: UINavigationController, theme: Theme) {
    navigationController.navigationBar.tintColor = theme.primaryFontColor
    navigationController.navigationBar.topItem?.backButtonTitle = ""
    navigationController.pushViewController(DetailModuleComposer.makeModule(theme: theme), animated: true)
  }
}
