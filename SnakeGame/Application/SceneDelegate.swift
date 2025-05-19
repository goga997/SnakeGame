//
//  SceneDelegate.swift
//  SnakeGame
//
//  Created by Grigore on 05.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let launchScreenView = UIView(frame: window.bounds)
        //launchScreenView.backgroundColor = UIColor.systemTeal
        applyLaunchGradient(to: launchScreenView)
        
        let logoImageView = UIImageView(image: UIImage(named: "LogoLaunchScreen"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        logoImageView.center = launchScreenView.center
        launchScreenView.addSubview(logoImageView)
        
        window.addSubview(launchScreenView)
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            launchScreenView.removeFromSuperview()
            
            let mainViewController = SetupViewController()
            window.rootViewController = mainViewController
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

