//
//  SceneDelegate.swift
//  Check✓
//
//  Created by George Rosescu on 20/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        if Session.userToken != nil{
            if let isCheckerRegister = Session.isRegisterChecker, isCheckerRegister {
                guard let checkerMainMenu = AppStoryboards.CheckerAppMainMenu.instance?.instantiateViewController(identifier: "CheckerTabBarViewController") else { return }
                let checkerMenuNavigationController = UINavigationController(rootViewController: checkerMainMenu)
                checkerMenuNavigationController.setNavigationBarHidden(true, animated: true)
                self.window?.rootViewController = checkerMenuNavigationController
            } else {
                guard let restaurantMainMenu = AppStoryboards.RestaurantMainApp.instance?.instantiateViewController(identifier: "RestaurantTabBarViewController") else { return }
                let restaurantMenuNavigationController = UINavigationController(rootViewController: restaurantMainMenu)
                restaurantMenuNavigationController.setNavigationBarHidden(true, animated: true)
                self.window?.rootViewController = restaurantMenuNavigationController
            }
            self.window?.makeKeyAndVisible()
        } else {
            if Session.passedFirstTimeOnboarding == true {
                guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") else { return }
                let authNavigationController = UINavigationController(rootViewController: loginVC)
                authNavigationController.setNavigationBarHidden(true, animated: true)
                self.window?.rootViewController = authNavigationController
                self.window?.makeKeyAndVisible()
            } else {
                guard let onBoardingVC = AppStoryboards.Onboarding.instance?.instantiateViewController(identifier: "OnboardingViewController") else { return }
                let boardingNavigationController = UINavigationController(rootViewController: onBoardingVC)
                boardingNavigationController.setNavigationBarHidden(true, animated: true)
                self.window?.rootViewController = boardingNavigationController
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

