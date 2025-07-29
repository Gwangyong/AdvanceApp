//
//  SceneDelegate.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/25/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    
    let bookSearchVC = UINavigationController(rootViewController: BookSearchViewController())
    let savedBooksVC = UINavigationController(rootViewController: SavedBooksViewController())
    
    let tabBarController = RootTabBarController()
    tabBarController.viewControllers = [bookSearchVC, savedBooksVC] // viewControllers: 각 탭에 들어갈 VC 화면들을 담는 배열
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    self.window = window
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  
  func sceneDidBecomeActive(_ scene: UIScene) {}
  
  func sceneWillResignActive(_ scene: UIScene) {}
  
  func sceneWillEnterForeground(_ scene: UIScene) {}
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
}
