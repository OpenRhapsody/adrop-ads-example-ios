//
//  SceneDelegate.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 11/14/23.
//

import UIKit
import AdropAds

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)

        // Create splash ad view controller with unit ID.
        let splashViewController = AdropSplashAdViewController(unitId: "PUBLIC_TEST_UNIT_ID_SPLASH")
        // Set background color of splash screen.
        splashViewController.backgroundColor = .systemBackground
        // Set logo image displayed during ad loading.
        splashViewController.logoImage = UIImage(named: "splash_logo")
        // Set main view controller to show after splash.
        splashViewController.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        // Set delegate to handle ad events.
        splashViewController.delegate = self

        self.window?.rootViewController = splashViewController
        self.window?.makeKeyAndVisible()
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

// MARK: - AdropSplashAdDelegate

extension SceneDelegate: AdropSplashAdDelegate {
    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropSplashAd) {
        print("onAdReceived \(ad.unitId) \(ad.creativeId)")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropSplashAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive: \(ad.unitId) error: \(AdropErrorCodeToString(code: errorCode))")
    }

    // Called when ad is displayed on screen.
    func onAdImpression(_ ad: AdropSplashAd) {
        print("onAdImpression: \(ad.unitId)")
    }
}
