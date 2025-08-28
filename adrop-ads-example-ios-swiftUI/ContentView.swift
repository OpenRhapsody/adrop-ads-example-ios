//
//  ContentView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Martin on 11/15/23.
//

import SwiftUI
import AdropAds

class AdropBannerWrapper: AdropBannerDelegate {
    let bannerRep: AdropBannerRepresented
    
    init(unitId: String){
        bannerRep = AdropBannerRepresented(unitId: unitId)
        bannerRep.banner.delegate = self
    }
    
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        print("onAdReceived")
    }
    
    func onAdClicked(_ banner: AdropAds.AdropBanner) {
        print("onAdClicked")
    }
    
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }
}

class AdropInterstitialAdWrapper: AdropInterstitialAdDelegate {
    var interstitialAd: AdropInterstitialAd?
    var errorHandler: (String) -> Void
    
    init(_ unitId: String, handler: @escaping (_ error: String) -> Void) {
        self.interstitialAd = AdropInterstitialAd(unitId: unitId)
        self.errorHandler = handler
        interstitialAd?.delegate = self
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdReceived(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdReceived")
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdImpression(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdImpression")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdClicked")
    }
    
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdWillPresentFullScreen")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdDidPresentFullScreen")
    }
    
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdWillDismissFullScreen")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdDidDismissFullScreen")
    }
    
    func load() {
        interstitialAd?.delegate = self
        interstitialAd?.load()
    }
    func show(fromRootViewController: UIViewController) {
        interstitialAd?.show(fromRootViewController: fromRootViewController)
    }
}


class AdropRewardedAdWrapper: AdropRewardedAdDelegate {
    var errorHandler: (String) -> Void
    
    init(_ unitId: String, handler: @escaping (String) -> Void ) {
        self.rewardedAd = AdropRewardedAd(unitId: unitId)
        self.errorHandler = handler
        rewardedAd?.delegate = self
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdReceived(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdReceived")
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdImpression(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdImpression")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdClicked")
    }
    
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdWillPresentFullScreen")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdDidPresentFullScreen")
    }
    
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdWillDismissFullScreen")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdDidDismissFullScreen")
    }
    
    var rewardedAd: AdropRewardedAd?
    
    func load() {
        rewardedAd?.delegate = self
        rewardedAd?.load()
    }
    func show(fromRootViewController: UIViewController, userDidEarnRewardHandler: @escaping AdropUserDidEarnRewardHandler) {
        rewardedAd?.show(fromRootViewController: fromRootViewController, userDidEarnRewardHandler:userDidEarnRewardHandler)
    }
}

struct AdFormat {
    let title: String
    let subtitle: String?
    let destination: String
    let icon: String
}

struct ContentView: View {
    let adFormats = [
        AdFormat(title: "배너 광고", subtitle: "다양한 크기 & 캐러셀", destination: "Banner", icon: "rectangle.split.2x1"),
        AdFormat(title: "전면 광고", subtitle: "전체 화면 표시", destination: "Interstitial", icon: "rectangle.stack.fill"),
        AdFormat(title: "네이티브 광고", subtitle: "피드 통합 & 커스텀 레이아웃", destination: "Native", icon: "doc.richtext"),
        AdFormat(title: "리워드 광고", subtitle: "비디오 & 정적 보상", destination: "Rewarded", icon: "gift"),
        AdFormat(title: "팝업 광고", subtitle: "모달 오버레이", destination: "Popup", icon: "app.badge"),
        AdFormat(title: "스플래시 광고", subtitle: "시작 화면 통합", destination: "Splash", icon: "sun.max")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(adFormats, id: \.title) { format in
                    NavigationLink(value: format.destination) {
                        HStack {
                            Image(systemName: format.icon)
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(format.title)
                                    .font(.headline)
                                if let subtitle = format.subtitle {
                                    Text(subtitle)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Adrop Example App")
            .navigationDestination(for: String.self) { value in
                switch value {
                case "Banner":
                    BannerView()
                case "Interstitial":
                    InterstitialAdView()
                case "Rewarded":
                    RewardedAdView()
                case "Native":
                    NativeAdView()
                case "Popup":
                    PopupAdView()
                case "Splash":
                    SplashAdView()
                default:
                    EmptyView()
                }
            }
        }
    }
}

