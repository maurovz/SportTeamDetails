import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private var navigationController: UINavigationController {
    let navigationController = UINavigationController()
    navigationController.setViewControllers([HomeModuleComposer.makeModule(navigationController: navigationController)], animated: false)
    return navigationController
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
