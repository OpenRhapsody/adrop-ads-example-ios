//
//  SplashAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds

// MARK: - SplashAdView

struct SplashAdView: UIViewRepresentable {
    static let unitId = "PUBLIC_TEST_UNIT_ID_SPLASH"
    fileprivate let completion: () -> Void
    fileprivate let splashVC: AdropSplashAdViewController

    init(completion: @escaping() -> Void) {
        self.completion = completion
        self.splashVC = AdropSplashAdViewController(unitId: Self.unitId)
    }

    func makeUIView(context: Context) -> UIView {
        // Set background color of splash screen.
        splashVC.backgroundColor = .white
        // Set logo image displayed during ad loading.
        splashVC.logoImage = UIImage(named: "splash_logo")
        // Set delegate to handle ad events.
        splashVC.delegate = context.coordinator

        return splashVC.view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }

    func makeCoordinator() -> SplashAdCoordinator {
        SplashAdCoordinator(splashAdView: self)
    }
}

// MARK: - SplashAdCoordinator

class SplashAdCoordinator: NSObject, AdropSplashAdDelegate {
    let splashAdView: SplashAdView

    init(splashAdView: SplashAdView) {
        self.splashAdView = splashAdView
    }

    // Called when splash ad closes.
    // impressed: true if the splash ad was displayed.
    func onAdClose(_ ad: AdropSplashAd, impressed: Bool) {
        UIView.animate(withDuration: impressed ? 0.3 : 0) {
            self.splashAdView.splashVC.view.alpha = 0
        } completion: { _ in
            self.splashAdView.completion()
        }
    }
}

#Preview {
    SplashAdView() {}
}
