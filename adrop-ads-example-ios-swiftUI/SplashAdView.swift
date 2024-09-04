//
//  SplashAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds

struct SplashAdView: UIViewRepresentable {
    static let unitId = "PUBLIC_TEST_UNIT_ID_SPLASH"
    fileprivate let completion: () -> Void
    fileprivate let splashVC: AdropSplashAdViewController
    
    init(completion: @escaping() -> Void) {
        self.completion = completion
        self.splashVC = AdropSplashAdViewController(unitId: Self.unitId)
    }
    
    func makeUIView(context: Context) -> UIView {
        splashVC.backgroundColor = .white
        splashVC.logoImage = UIImage(named: "splash_logo")

        splashVC.displayDuration = 1    // 스플래시 광고 노출시간 입니다. 0.5~3 사이의 값을 입력하실 수 있습니다.
        splashVC.delegate = context.coordinator
        
        return splashVC.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> SplashAdCoordinator {
        SplashAdCoordinator(splashAdView: self)
    }
}

class SplashAdCoordinator: NSObject, AdropSplashAdDelegate {
    let splashAdView: SplashAdView
    
    init(splashAdView: SplashAdView) {
        self.splashAdView = splashAdView
    }
    
    // 스플래시 광고가 종료되었을 때, 호출되는 콜백함수 입니다.
    // impressed 가 true 일 경우, 스플래시 광고가 노출되었음을 의미합니다.
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
